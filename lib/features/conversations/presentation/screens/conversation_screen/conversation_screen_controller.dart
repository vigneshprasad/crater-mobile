import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kiwi/kiwi.dart';

import '../../../../../core/api_result/api_result.dart';
import '../../../../../core/error/failures/failures.dart';
import '../../../../auth/domain/entity/user_entity.dart';
import '../../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../data/repository/conversation_repository_impl.dart';
import '../../../data/services/roundtable_rtc_client/roundtable_rtc_client.dart';
import '../../../domain/entity/conversation_entity/conversation_entity.dart';
import '../../../domain/entity/conversation_request_entity/conversation_request_entity.dart';
import '../../../domain/entity/conversation_rtc_info_entity/conversation_rtc_info_entity.dart';
import '../../../domain/entity/rtc_user_entity/rtc_user_entity.dart';
import 'conversation_overlay_controller.dart';

enum RtcConnectionState { connected, connecting, disconnected }

final conversationScreenControllerProvider =
    ChangeNotifierProvider.family<ConversationScreenController, Conversation>(
        (ref, table) {
  final localUser = KiwiContainer().resolve<AuthBloc>().state.user!;

  return ConversationScreenController(ref.read, table, localUser);
});

final getRoundTableNotifier = StateNotifierProvider.family<GetRoundTableState,
    ApiResult<Conversation>, int>((ref, tableId) {
  return GetRoundTableState(ref.read, tableId);
});

class GetRoundTableState extends StateNotifier<ApiResult<Conversation>> {
  final Reader read;
  final int tableId;

  GetRoundTableState(
    this.read,
    this.tableId,
  ) : super(ApiResult<Conversation>.loading()) {
    getTableInfo(tableId);
  }

  Future<Either<Failure, Conversation>> getTableInfo(int id) async {
    // Loading state intialized
    state = ApiResult<Conversation>.loading();

    final response =
        await read(conversationRepositoryProvider).retreiveConversation(id);

    state = response.fold(
      (failure) => ApiResult<Conversation>.error(failure),
      (table) => ApiResult<Conversation>.data(table),
    );

    return response;
  }
}

class ConversationScreenController extends ChangeNotifier {
  final Reader read;
  final Conversation? _table;
  final User? _localUser;

  late RtcConnectionState _connectionState;
  late List<RtcUser> _speakers;
  late bool _showConnectionBar;
  late ConversationRtcInfo _rtcInfo;

  ConversationScreenController(this.read, this._table, this._localUser) {
    _connectionState = RtcConnectionState.disconnected;
    _speakers = intializeSpeakers(_table!);
    _showConnectionBar = false;
    notifyListeners();
  }

  // Getters
  User? get localAuthUser => _localUser;
  Conversation? get table => _table;
  RtcConnectionState get connectionState => _connectionState;
  List<RtcUser> get speakers => _speakers;
  bool get showConnectionBar => _showConnectionBar;

  bool hasOngoingMeeting() =>
      read(groupOverlayControllerProvider).entry != null;

  RtcUser? get locaRtclUser {
    if (_localUser == null) {
      return null;
    }
    return _speakers.firstWhere((element) => element.pk == _localUser?.pk);
  }

  List<RtcUser> intializeSpeakers(Conversation table) {
    final List<RtcUser> initial = [];
    // if (table.host != null) {
    //   initial.add(RtcUser(
    //     userInfo: table.hostDetail,
    //     pk: table.hostDetail.pk,
    //     online: false,
    //     muted: false,
    //   ));
    // }

    initial.addAll(table.speakersDetailList?.map(
          (speaker) => RtcUser(
            userInfo: speaker,
            pk: speaker.pk!,
            online: false,
            muted: false,
          ),
        ) ??
        []);

    return initial;
  }

  Future<Either<Failure, ConversationRequest>> requestToJoinGroup(
      int group) async {
    final request = ConversationRequest(group: group);
    return read(conversationRepositoryProvider).postRequestToJoinGroup(request);
  }

  Future<void> joinRoundTableChannel(User localUser) async {
    if (hasOngoingMeeting()) {
      // return;
      await read(roundTableRtcClientProvider).dispose();

      read(groupOverlayControllerProvider).removeOverlayEntry();
    }

    // Reset Speakers List
    _speakers = intializeSpeakers(_table!);

    final responseOrError = await read(conversationRepositoryProvider)
        .getConversationRtcInfo(_table!.id!);

    responseOrError.fold(
      (failure) {
        Fluttertoast.showToast(msg: failure.message!);
      },
      (info) => _connectToRtcChannel(localUser, info),
    );
  }

  Future<void> _connectToRtcChannel(
      User localUser, ConversationRtcInfo info) async {
    _showConnectionBar = true;
    _connectionState = RtcConnectionState.connecting;
    _rtcInfo = info;
    notifyListeners();
    final _rtcClient = read(roundTableRtcClientProvider);
    await _rtcClient.initEngine();
    _setRtcEventHandlers(localUser);
    try {
      await _rtcClient.joinRoundTableChannel(
          info.channelName, info.token, localUser.pk!);
    } catch (exception) {
      Fluttertoast.showToast(msg: 'Some error occurred. Please try again.');
      debugPrint(exception.toString());

      await leaveRoundTableChannel();
    }
  }

  Future<void> leaveRoundTableChannel() async {
    read(groupOverlayControllerProvider).removeOverlayEntry();
    await read(roundTableRtcClientProvider).dispose();
    _connectionState = RtcConnectionState.disconnected;
    _showConnectionBar = false;
    // Reset Speakers List
    _speakers = intializeSpeakers(_table!);
    notifyListeners();
  }

  Future<void> muteLocalAudioStream({required bool muted}) async {
    await read(roundTableRtcClientProvider).muteLocalAudio(muted: muted);
    final index =
        _speakers.indexWhere((element) => element.pk == _localUser!.pk);
    if (index > -1) {
      _speakers[index] = _speakers[index].copyWith(muted: muted);
    }
    notifyListeners();
  }

  void _setRtcEventHandlers(User localUser) {
    read(roundTableRtcClientProvider).setEventHandler(
      RtcEngineEventHandler(
        joinChannelSuccess: (channel, uid, elapsed) =>
            _onJoinChannelSuccess(localUser),
        error: (err) => _onError(err),
        userJoined: (uid, elapsed) => _onRemoteUserJoined(uid, elapsed),
        audioVolumeIndication: (speakers, totalVolume) =>
            _onAudioVolumeIndicationChange(speakers, totalVolume),
        userOffline: (uid, reason) => _onRemoteUserOffline(uid, reason),
        connectionStateChanged: (state, reason) =>
            _onConnectionStateChanged(state, reason),
        remoteAudioStateChanged: (uid, state, reason, elapsed) =>
            _onRemoteAudioStateChanged(uid, state, reason, elapsed),
        firstRemoteAudioDecoded: (uid, elapsed) =>
            _onRemoteAudioDecoded(uid, elapsed),
      ),
    );
  }

  void _toggleSpeakerOnlineState(String pk, bool online) {
    final index = _speakers.indexWhere((element) => element.pk == pk);
    if (index > -1) {
      _speakers[index] = _speakers[index].copyWith(
        online: online,
        muted: false,
        volume: 0,
      );
    }
    notifyListeners();
  }

  // Event Handler for rtc events
  void _onJoinChannelSuccess(User localUser) {
    _connectionState = RtcConnectionState.connected;
    _toggleSpeakerOnlineState(localUser.pk!, true);
    notifyListeners();
  }

  Future<void> _renewTokenToRtcEngine() async {
    final responseOrError = await read(conversationRepositoryProvider)
        .getConversationRtcInfo(_table!.id!);

    responseOrError.fold(
      (failure) {
        _connectionState = RtcConnectionState.disconnected;
        _showConnectionBar = false;
        notifyListeners();
        Fluttertoast.showToast(msg: failure.message!);
      },
      (info) async {
        _rtcInfo = info;
        notifyListeners();
        await read(roundTableRtcClientProvider).renewToken(info.token);
      },
    );
  }

  Future<void> _onConnectionStateChanged(
      ConnectionStateType state, ConnectionChangedReason reason) async {
    switch (state) {
      case ConnectionStateType.Connected:
        if (_connectionState != RtcConnectionState.connected) {
          _connectionState = RtcConnectionState.connected;
          notifyListeners();
        }
        break;
      case ConnectionStateType.Disconnected:
        _connectionState = RtcConnectionState.disconnected;
        _showConnectionBar = false;
        notifyListeners();
        return;

      case ConnectionStateType.Reconnecting:
      case ConnectionStateType.Connecting:
        _connectionState = RtcConnectionState.connecting;
        notifyListeners();
        return;
      case ConnectionStateType.Failed:
        if (reason == ConnectionChangedReason.TokenExpired) {
          await _renewTokenToRtcEngine();
        }
        return;
      default:
        return;
    }
  }

  Future<void> _onAudioVolumeIndicationChange(
      List<AudioVolumeInfo> speakers, int totalVolume) async {
    for (final speaker in speakers) {
      try {
        String? rtcUid;
        // Represents local user
        if (speaker.uid == 0) {
          rtcUid = _localUser?.pk;
        } else {
          final info = await read(roundTableRtcClientProvider)
              .engine
              ?.getUserInfoByUid(speaker.uid);
          rtcUid = info?.userAccount;
        }

        final index = _speakers.indexWhere((element) => element.pk == rtcUid);
        if (index > -1) {
          _speakers[index] = _speakers[index].copyWith(volume: speaker.volume);
        }
        notifyListeners();
      } catch (error) {
        debugPrint(error.toString());
      }
    }
  }

  Future<void> _onRemoteAudioStateChanged(
    int uid,
    AudioRemoteState state,
    AudioRemoteStateReason reason,
    int elapsed,
  ) async {
    final states = [
      AudioRemoteState.Stopped,
      AudioRemoteState.Starting,
    ];
    if (reason == AudioRemoteStateReason.RemoteMuted ||
        reason == AudioRemoteStateReason.Internal) {
      if (states.contains(state)) {
        final muted = state != AudioRemoteState.Starting;
        final info = await read(roundTableRtcClientProvider)
            .engine
            ?.getUserInfoByUid(uid);
        final rtcUid = info?.userAccount;
        if (rtcUid != null) {
          final index = _speakers.indexWhere((element) => element.pk == rtcUid);
          if (index > -1) {
            _speakers[index] = _speakers[index].copyWith(muted: muted);
          }
        }
      }
    }
    notifyListeners();
  }

  Future<void> _onRemoteUserJoined(int uid, int elapsed) async {
    final info =
        await read(roundTableRtcClientProvider).engine?.getUserInfoByUid(uid);
    final rtcUid = info?.userAccount;
    if (rtcUid != null) {
      _toggleSpeakerOnlineState(rtcUid, true);
      notifyListeners();
    }
  }

  Future<void> _onRemoteAudioDecoded(int uid, int elapsed) async {
    final info =
        await read(roundTableRtcClientProvider).engine?.getUserInfoByUid(uid);
    final rtcUid = info?.userAccount;
    if (rtcUid != null) {
      _toggleSpeakerOnlineState(rtcUid, true);
      notifyListeners();
    }
  }

  Future<void> _onRemoteUserOffline(int uid, UserOfflineReason reason) async {
    final info =
        await read(roundTableRtcClientProvider).engine?.getUserInfoByUid(uid);
    final rtcUid = info?.userAccount;
    if (rtcUid != null) {
      _toggleSpeakerOnlineState(rtcUid, false);
      notifyListeners();
    }
  }

  Future<void> _onError(ErrorCode err) async {
    Fluttertoast.showToast(msg: err.toString());
    final _rtcClient = read(roundTableRtcClientProvider);
    if (err == ErrorCode.InvalidToken) {
      _rtcClient.engine?.leaveChannel();
      _connectionState = RtcConnectionState.disconnected;
      _showConnectionBar = false;
    } else if (err == ErrorCode.JoinChannelRejected) {
      _rtcClient.engine?.leaveChannel();
      _connectionState = RtcConnectionState.disconnected;
      _showConnectionBar = false;
    } else if (err == ErrorCode.TokenExpired) {
      await _rtcClient.engine?.leaveChannel();
      _connectionState = RtcConnectionState.disconnected;
      _showConnectionBar = false;
    }

    notifyListeners();
  }

  // OverlayEntry _createOverlayEntry() {
  //   return OverlayEntry(builder: (context) {
  //     return ConversationOverlayIndicator(table: table);
  //   });
  // }

  // void showOverlayEntry(BuildContext context) {
  //   final entry = _createOverlayEntry();
  //   read(groupOverlayControllerProvider)
  //       .createOverlayEntry(context, entry, table);
  // }

  void hideOverlayEntry() {
    final _groupOverlayController = read(groupOverlayControllerProvider);
    final isSameTable = table?.id == _groupOverlayController.table?.id;
    if (!isSameTable) {
      return;
    }
    _groupOverlayController.removeOverlayEntry();
  }
}
