import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kiwi/kiwi.dart';
import 'package:worknetwork/core/analytics/analytics.dart';
import 'package:worknetwork/core/analytics/anlytics_events.dart';

import '../../../../../core/api_result/api_result.dart';
import '../../../../../core/error/failures/failures.dart';
import '../../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../data/repository/conversation_repository_impl.dart';
import '../../../domain/entity/conversation_entity/conversation_entity.dart';
import '../../../domain/entity/conversation_request_entity/conversation_request_entity.dart';
import '../../../domain/entity/rtc_user_entity/rtc_user_entity.dart';
import '../../widgets/conversation_overlay_indicator/conversation_overlay_controller.dart';
import '../../widgets/conversation_overlay_indicator/conversation_overlay_indicator.dart';

enum RtcConnection { connected, connecting, disconnected }

class ConversationScreenData {
  final Conversation conversation;
  final bool isRSVPed;

  ConversationScreenData(this.conversation, this.isRSVPed);
}

final conversationStateProvider = StateNotifierProvider.autoDispose
    .family<ConversationState, ApiResult<ConversationScreenData>, int>(
        (ref, id) => ConversationState(ref.read, id));

final conversationSpeakersState = StateNotifierProvider.autoDispose
    .family<ConversationSpeakersState, List<RtcUser>, int>(
        (ref, id) => ConversationSpeakersState(ref.read));

final rtcConnectionProvider = ChangeNotifierProvider.autoDispose
    .family<RtcConnectionState, int>((ref, id) => RtcConnectionState());

class RtcConnectionState extends ChangeNotifier {
  RtcConnection _connection;

  RtcConnectionState() : _connection = RtcConnection.disconnected;

  RtcConnection get connection => _connection;

  set connection(RtcConnection connection) {
    _connection = connection;
    notifyListeners();
  }
}

class ConversationState extends StateNotifier<ApiResult<ConversationScreenData>> {
  final Reader read;
  final int _groupId;

  ConversationState(this.read, this._groupId)
      : super(ApiResult.loading()) {
    retrieveConversation();
  }

  Future<Either<Failure, Conversation>> retrieveConversation({bool justRSVPed = false}) async {
    final response = await read(conversationRepositoryProvider)
        .retreiveConversation(_groupId);
    
    final requestResponse = await read(conversationRepositoryProvider)
        .getWebinarRSVPRequest(_groupId);

    state = response.fold(
      (failure) => ApiResult.error(failure),
      (group) {
        read(conversationSpeakersState(_groupId).notifier)
            .setInitialSpeakers(group.speakersDetailList!);

        final isRSVPed = justRSVPed || requestResponse.isRight();
        final data = ConversationScreenData(group, isRSVPed);
        return ApiResult.data(data);
      },
    );

    return response;
  }

  Future<Either<Failure, ConversationRequest>> postRequestToJoinGroup() async {
    final request = ConversationRequest(
      group: _groupId,
      participantType: ParticpantType.attendee,
      status: RequestStatus.accepted,
    );
    final response = await read(conversationRepositoryProvider)
        .postRequestToJoinGroup(request);

    return response;
  }

  // Future<void> connectToAudioCall() async {
  //   final user = KiwiContainer().resolve<AuthBloc>().state.user!;
  //   read(rtcConnectionProvider(_groupId)).connection = RtcConnection.connecting;
  //   final response = await read(conversationRepositoryProvider)
  //       .getConversationRtcInfo(_groupId);

  //   response.fold(
  //     (failure) => Fluttertoast.showToast(msg: failure.message!),
  //     (info) {
  //       _connectToRtcAudioCall(info, user);
  //     },
  //   );
  // }

  // Future<void> _connectToRtcAudioCall(
  //     ConversationRtcInfo info, User user) async {
  //   await read(conversationRtcClient).initEngine();
  //   try {
  //     _setAudioCallHandlers();
  //     await read(conversationRtcClient).joinAudioCall(
  //       info.channelName!,
  //       info.token!,
  //       user.pk!,
  //     );
  //   } catch (exception) {
  //     Fluttertoast.showToast(msg: 'Some error occurred. Please try again.');
  //     debugPrint(exception.toString());

  //     await leaveAudioCall();
  //   }
  // }

  Future<void> muteLocalAudio({required bool muted}) async {
    final user = read(conversationSpeakersState(_groupId).notifier).localUser;
    // await read(conversationRtcClient).muteLocalAudio(muted: muted);

    read(conversationSpeakersState(_groupId).notifier)
        .toggleMutedState(user.pk!, muted: !user.muted);
  }

  void createAudioCallOverlay(BuildContext context) {
    final entry = _createOverlayEntry();
    read(conversationOverlayProvider)
        .createOverlayEntry(context, entry, _groupId);
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(builder: (context) {
      return ConversationOverlayIndicator(tableId: _groupId);
    });
  }

  /// RTC Call Event Handlers
  ///
  // void _setAudioCallHandlers() {
  //   final localUser = KiwiContainer().resolve<AuthBloc>().state.user!;
  //   read(conversationRtcClient).setEventHandler(RtcEngineEventHandler(
  //     joinChannelSuccess: (channel, uid, elapsed) =>
  //         _onJoinChannelSuccess(channel, uid, elapsed, localUser.pk!),
  //     userJoined: (uid, elapsed) => _onRemoteUserJoined(uid, elapsed),
  //     localAudioStateChanged: (state, error) =>
  //         _onLocalAudioStateChanged(state, error),
  //     audioVolumeIndication: (speakers, totalVolume) =>
  //         _onAudioVolumeIndicationChange(speakers, totalVolume),
  //     userOffline: (uid, reason) => _onRemoteUserOffline(uid, reason),
  //     connectionStateChanged: (state, reason) =>
  //         _onConnectionStateChanged(state, reason),
  //     remoteAudioStateChanged: (uid, state, reason, elapsed) =>
  //         _onRemoteAudioStateChanged(uid, state, reason, elapsed),
  //     firstRemoteAudioDecoded: (uid, elapsed) =>
  //         _onRemoteAudioDecoded(uid, elapsed),
  //     error: (err) => _onErrorRtc(err),
  //   ));
  // }

  // Future<void> leaveAudioCall() async {
  //   state.maybeWhen(
  //     orElse: () {},
  //     data: (Conversation group) async {
  //       await read(conversationRtcClient).dispose();
  //       read(rtcConnectionProvider(_groupId)).connection =
  //           RtcConnection.disconnected;
  //       read(conversationSpeakersState(_groupId).notifier)
  //           .setInitialSpeakers(group.speakersDetailList!);
  //     },
  //   );
  // }

  void _onJoinChannelSuccess(String channel, int uid, int elapsed, String pk) {
    final analytics = KiwiContainer().resolve<Analytics>();
    analytics.trackEvent(
        eventName: AnalyticsEvents.conversationGroupAttended,
        properties: {
          "id": _groupId,
        });
    read(rtcConnectionProvider(_groupId)).connection = RtcConnection.connected;
    read(conversationSpeakersState(_groupId).notifier)
        .toggleOnlineState(pk, online: true);
  }

  // Future<void> _onErrorRtc(ErrorCode err) async {
  //   await leaveAudioCall();
  // }

  // Future<void> _onRemoteUserJoined(int uid, int elapsed) async {
  //   final info =
  //       await read(conversationRtcClient).engine?.getUserInfoByUid(uid);
  //   final pk = info?.userAccount;

  //   if (pk != null) {
  //     final response = await read(conversationRepositoryProvider)
  //         .retreiveConversation(_groupId);

  //     response.fold(
  //       (failure) {},
  //       (conversation) {
  //         read(conversationSpeakersState(_groupId).notifier)
  //             .mergeUpdatedSpeakersList(conversation.speakersDetailList!);

  //         read(conversationSpeakersState(_groupId).notifier)
  //             .toggleOnlineState(pk, online: true);
  //       },
  //     );
  //   }
  // }

  // Future<void> _onAudioVolumeIndicationChange(
  //     List<AudioVolumeInfo> speakers, int totalVolume) async {
  //   for (final speaker in speakers) {
  //     final info = await read(conversationRtcClient)
  //         .engine
  //         ?.getUserInfoByUid(speaker.uid);
  //     final pk = info?.userAccount;

  //     if (pk != null) {
  //       read(conversationSpeakersState(_groupId).notifier)
  //           .toggleVolumeIndicator(pk, speaker.volume);
  //     }
  //   }
  // }

  // Future<void> _onRemoteUserOffline(int uid, UserOfflineReason reason) async {
  //   final info =
  //       await read(conversationRtcClient).engine?.getUserInfoByUid(uid);

  //   final pk = info?.userAccount;

  //   if (pk != null) {
  //     read(conversationSpeakersState(_groupId).notifier).toggleOnlineState(pk);
  //   }
  // }

  // Future<void> _onConnectionStateChanged(
  //     ConnectionStateType state, ConnectionChangedReason reason) async {
  //   final _connectionState = read(rtcConnectionProvider(_groupId)).connection;
  //   switch (state) {
  //     case ConnectionStateType.Connected:
  //       if (_connectionState != RtcConnection.connected) {
  //         read(rtcConnectionProvider(_groupId)).connection =
  //             RtcConnection.connected;
  //       }
  //       break;
  //     case ConnectionStateType.Disconnected:
  //       read(rtcConnectionProvider(_groupId)).connection =
  //           RtcConnection.disconnected;
  //       return;

  //     case ConnectionStateType.Reconnecting:
  //     case ConnectionStateType.Connecting:
  //       read(rtcConnectionProvider(_groupId)).connection =
  //           RtcConnection.connecting;
  //       return;
  //     case ConnectionStateType.Failed:
  //       if (reason == ConnectionChangedReason.TokenExpired) {
  //         // await _renewTokenToRtcEngine();
  //       }
  //       return;
  //     default:
  //       return;
  //   }
  // }

  // Future<void> _onRemoteAudioStateChanged(int uid, AudioRemoteState state,
  //     AudioRemoteStateReason reason, int elapsed) async {
  //   final states = [
  //     AudioRemoteState.Stopped,
  //     AudioRemoteState.Starting,
  //   ];
  //   if (reason == AudioRemoteStateReason.RemoteMuted ||
  //       reason == AudioRemoteStateReason.Internal) {
  //     if (states.contains(state)) {
  //       final muted = state != AudioRemoteState.Starting;
  //       final info =
  //           await read(conversationRtcClient).engine?.getUserInfoByUid(uid);
  //       final pk = info?.userAccount;
  //       if (pk != null) {
  //         read(conversationSpeakersState(_groupId).notifier)
  //             .toggleMutedState(pk, muted: muted);
  //       }
  //     }
  //   }
  // }

  // Future<void> _onRemoteAudioDecoded(int uid, int elapsed) async {
  //   final info =
  //       await read(conversationRtcClient).engine?.getUserInfoByUid(uid);

  //   final pk = info?.userAccount;

  //   if (pk != null) {
  //     read(conversationSpeakersState(_groupId).notifier)
  //         .toggleOnlineState(pk, online: true);
  //   }
  // }

  // Future<void> _onLocalAudioStateChanged(
  //     AudioLocalState state, AudioLocalError error) async {
  //   final localUser =
  //       read(conversationSpeakersState(_groupId).notifier).localUser;
  //   if (error == AudioLocalError.Ok) {
  //     if (state == AudioLocalState.Stopped) {
  //       read(conversationSpeakersState(_groupId).notifier)
  //           .toggleMutedState(localUser.pk!, muted: true);
  //     } else if (state == AudioLocalState.Recording) {
  //       read(conversationSpeakersState(_groupId).notifier)
  //           .toggleMutedState(localUser.pk!);
  //     }
  //   }
  // }
}

class ConversationSpeakersState extends StateNotifier<List<RtcUser>> {
  final Reader read;

  ConversationSpeakersState(this.read) : super(<RtcUser>[]);

  RtcUser get localUser {
    final user = KiwiContainer().resolve<AuthBloc>().state.user!;
    return state.firstWhere((element) => element.pk == user.pk);
  }

  void setInitialSpeakers(List<ConversationUser> speakers) {
    state = [
      for (final speaker in speakers)
        RtcUser(
          userInfo: speaker,
          pk: speaker.pk,
          online: false,
          muted: false,
          volume: 0,
        )
    ];
  }

  void toggleOnlineState(String pk, {bool online = false}) {
    state = [
      for (final speaker in state)
        if (speaker.pk == pk)
          speaker.copyWith(
            online: online,
          )
        else
          speaker
    ];
  }

  void toggleMutedState(String pk, {bool muted = false}) {
    state = [
      for (final speaker in state)
        if (speaker.pk == pk)
          speaker.copyWith(
            muted: muted,
          )
        else
          speaker
    ];
  }

  void toggleVolumeIndicator(String pk, int volume) {
    state = [
      for (final speaker in state)
        if (speaker.pk == pk)
          speaker.copyWith(
            volume: volume,
          )
        else
          speaker
    ];
  }

  void mergeUpdatedSpeakersList(List<ConversationUser> speakers) {
    final newSpeakers = speakers.where((element) {
      final val = state.indexWhere((user) => user.pk == element.pk);
      return val == -1;
    }).toList();

    state = [
      ...state,
      for (final speaker in newSpeakers)
        RtcUser(
          userInfo: speaker,
          pk: speaker.pk,
          online: false,
          muted: false,
          volume: 0,
        )
    ];
  }
}
