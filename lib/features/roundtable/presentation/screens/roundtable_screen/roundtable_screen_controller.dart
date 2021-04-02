import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:kiwi/kiwi.dart';
import 'package:worknetwork/features/roundtable/presentation/screens/roundtable_screen/meeting_controller.dart';
import 'package:worknetwork/features/roundtable/presentation/widgets/roundtable_overlay_indicator/roundtable_overlay_indicator.dart';

import '../../../../../core/api_result/api_result.dart';
import '../../../../../core/error/failures/failures.dart';
import '../../../../auth/domain/entity/user_entity.dart';
import '../../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../data/repository/roundtable_repository_impl.dart';
import '../../../data/services/roundtable_rtc_client/roundtable_rtc_client.dart';
import '../../../domain/entity/group_request/group_request_enitity.dart';
import '../../../domain/entity/roundtable_entity/roundtable_entity.dart';
import '../../../domain/entity/roundtable_rtc_info/roundtable_rtc_info.dart';
import '../../../domain/entity/rtc_user_entity/rtc_user_entity.dart';
import '../../../domain/repository/roundtable_repository.dart';

enum RtcConnectionState { connected, connecting, disconnected }

final roundTableScreenControllerProvider = ChangeNotifierProvider.autoDispose
    .family<RoundTableScreenController, RoundTable>((ref, table) {
  final repository = ref.watch(roundtableRepositoryProvider);
  final rtcClient = ref.watch(roundTableRtcClientProvider);
  final localUser = KiwiContainer().resolve<AuthBloc>().state.user;
  final groupOverlayProvider = ref.watch(groupOverlayControllerProvider);

  // ref.onDispose(() {
  // rtcClient.engine?.destroy();
  // });

  return RoundTableScreenController(
      repository, rtcClient, table, localUser, groupOverlayProvider);
});

final getRoundTableNotifier = StateNotifierProvider.autoDispose
    .family<GetRoundTableState, int>((ref, tableId) {
  final repository = ref.read(roundtableRepositoryProvider);
  return GetRoundTableState(repository, tableId);
});

class GetRoundTableState extends StateNotifier<ApiResult<RoundTable>> {
  final RoundTableRepository _repository;
  final int tableId;

  GetRoundTableState(
    this._repository,
    this.tableId,
  ) : super(ApiResult<RoundTable>.loading()) {
    getTableInfo(tableId);
  }

  Future<Either<Failure, RoundTable>> getTableInfo(int id) async {
    // Loading state intialized
    state = ApiResult<RoundTable>.loading();

    final response = await _repository.retrieveRoundTable(id);

    state = response.fold(
      (failure) => ApiResult<RoundTable>.error(failure),
      (table) => ApiResult<RoundTable>.data(table),
    );

    return response;
  }
}

class RoundTableScreenController extends ChangeNotifier {
  final RoundTableRtcClient _rtcClient;
  final RoundTableRepository _repository;
  final RoundTable _table;
  final User _localUser;
  final GroupOverlayController _groupOverlayController;

  RtcConnectionState _connectionState;
  List<RtcUser> _speakers;
  bool _showConnectionBar;
  RoundtableRtcInfo _rtcInfo;

  RoundTableScreenController(this._repository, this._rtcClient, this._table,
      this._localUser, this._groupOverlayController) {
    _connectionState = RtcConnectionState.disconnected;
    _speakers = intializeSpeakers(_table);
    _showConnectionBar = false;
    notifyListeners();
  }

  // Getters
  User get localAuthUser => _localUser;
  RoundTable get table => _table;
  RtcConnectionState get connectionState => _connectionState;
  List<RtcUser> get speakers => _speakers;
  bool get showConnectionBar => _showConnectionBar;

  bool hasOngoingMeeting() => _groupOverlayController.entry != null;

  RtcUser get locaRtclUser {
    if (_localUser == null) {
      return null;
    }
    return _speakers.firstWhere((element) => element.pk == _localUser.pk);
  }

  List<RtcUser> intializeSpeakers(RoundTable table) {
    List<RtcUser> initial = [];
    if (table.host != null) {
      initial.add(RtcUser(
        userInfo: table.hostDetail,
        pk: table.hostDetail.pk,
        online: false,
        muted: false,
      ));
    }

    initial.addAll(table.speakersDetailList.map(
      (speaker) => RtcUser(
        userInfo: speaker,
        pk: speaker.pk,
        online: false,
        muted: false,
      ),
    ));

    return initial;
  }

  Future<Either<Failure, GroupRequest>> requestToJoinGroup(int group) async {
    final request = GroupRequest(group: group);
    return _repository.postRequestToJoinGroup(request);
  }

  Future<void> joinRoundTableChannel(User localUser) async {
    if (hasOngoingMeeting()) {
      // return;
      await _rtcClient.dispose();

      _groupOverlayController.removeOverlayEntry();
    }

    // Reset Speakers List
    _speakers = intializeSpeakers(_table);

    final responseOrError = await _repository.getRoundTableRtcInfo(_table.id);

    responseOrError.fold(
      (failure) {
        Fluttertoast.showToast(msg: failure.message);
      },
      (info) => _connectToRtcChannel(localUser, info),
    );
  }

  Future<void> _connectToRtcChannel(
      User localUser, RoundtableRtcInfo info) async {
    _showConnectionBar = true;
    _connectionState = RtcConnectionState.connecting;
    _rtcInfo = info;
    notifyListeners();
    await _rtcClient.initEngine();
    _setRtcEventHandlers(localUser);
    await _rtcClient.joinRoundTableChannel(
        info.channelName, info.token, localUser.pk);
  }

  Future<void> leaveRoundTableChannel() async {
    await _rtcClient.dispose();
    _groupOverlayController.removeOverlayEntry();
    _connectionState = RtcConnectionState.disconnected;
    _showConnectionBar = false;
    // Reset Speakers List
    _speakers = intializeSpeakers(_table);
    notifyListeners();
  }

  Future<void> muteLocalAudioStream({@required bool muted}) async {
    await _rtcClient.muteLocalAudio(muted: muted);
    final index =
        _speakers.indexWhere((element) => element.pk == _localUser.pk);
    if (index > -1) {
      _speakers[index] = _speakers[index].copyWith(muted: muted);
    }
    notifyListeners();
  }

  void _setRtcEventHandlers(User localUser) {
    _rtcClient.setEventHandler(
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
    _toggleSpeakerOnlineState(localUser.pk, true);
    notifyListeners();
  }

  Future<void> _renewTokenToRtcEngine() async {
    final responseOrError = await _repository.getRoundTableRtcInfo(_table.id);

    responseOrError.fold(
      (failure) {
        _connectionState = RtcConnectionState.disconnected;
        _showConnectionBar = false;
        notifyListeners();
        Fluttertoast.showToast(msg: failure.message);
      },
      (info) async {
        _rtcInfo = info;
        notifyListeners();
        await _rtcClient.renewToken(info.token);
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
        String rtcUid;
        // Represents local user
        if (speaker.uid == 0) {
          rtcUid = _localUser.pk;
        } else {
          final info = await _rtcClient.engine.getUserInfoByUid(speaker.uid);
          rtcUid = info.userAccount;
        }

        final index = _speakers.indexWhere((element) => element.pk == rtcUid);
        if (index > -1) {
          _speakers[index] = _speakers[index].copyWith(volume: speaker.volume);
        }
        notifyListeners();
      } catch (error) {
        print(error);
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
        final info = await _rtcClient.engine.getUserInfoByUid(uid);
        final rtcUid = info.userAccount;
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
    final info = await _rtcClient.engine.getUserInfoByUid(uid);
    final rtcUid = info.userAccount;
    if (rtcUid != null) {
      _toggleSpeakerOnlineState(rtcUid, true);
      notifyListeners();
    }
  }

  Future<void> _onRemoteAudioDecoded(int uid, int elapsed) async {
    final info = await _rtcClient.engine.getUserInfoByUid(uid);
    final rtcUid = info.userAccount;
    if (rtcUid != null) {
      _toggleSpeakerOnlineState(rtcUid, true);
      notifyListeners();
    }
  }

  Future<void> _onRemoteUserOffline(int uid, UserOfflineReason reason) async {
    final info = await _rtcClient.engine.getUserInfoByUid(uid);
    final rtcUid = info.userAccount;
    if (rtcUid != null) {
      _toggleSpeakerOnlineState(rtcUid, false);
      notifyListeners();
    }
  }

  Future<void> _onError(ErrorCode err) async {
    Fluttertoast.showToast(msg: err.toString());
    if (err == ErrorCode.InvalidToken) {
      _rtcClient.engine.leaveChannel();
      _connectionState = RtcConnectionState.disconnected;
      _showConnectionBar = false;
    } else if (err == ErrorCode.JoinChannelRejected) {
      _rtcClient.engine.leaveChannel();
      _connectionState = RtcConnectionState.disconnected;
      _showConnectionBar = false;
    } else if (err == ErrorCode.TokenExpired) {
      await _rtcClient.engine.leaveChannel();
      _connectionState = RtcConnectionState.disconnected;
      _showConnectionBar = false;
    }

    notifyListeners();
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(builder: (context) {
      return RoundTableOverlayIndicator(table: table);
    });
  }

  void showOverlayEntry(BuildContext context) {
    final entry = _createOverlayEntry();
    _groupOverlayController.createOverlayEntry(context, entry);
  }

  void hideOverlayEntry() {
    _groupOverlayController.removeOverlayEntry();
  }
}
