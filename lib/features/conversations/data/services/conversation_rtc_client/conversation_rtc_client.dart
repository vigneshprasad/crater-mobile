import 'package:agora_rtc_engine/rtc_engine.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../core/config_reader/config_reader.dart';

final conversationRtcClient = Provider((_) => ConversationRtcClient());

class ConversationRtcClient {
  RtcEngine? _engine;

  RtcEngine? get engine => _engine;

  Future<void> initEngine() async {
    if (_engine != null) {
      _engine = null;
    }

    // Get microphone permission
    await Permission.microphone.request();

    // await PermissionHandler().requestPermissions([
    //   PermissionGroup.microphone,
    // ]);

    // Create RTC client instance
    _engine = await RtcEngine.create(ConfigReader.getAgoraAppId());
  }

  Future<void> joinAudioCall(
    String channelName,
    String token,
    String account,
  ) async {
    if (_engine == null) {
      await initEngine();
    }
    await _engine!.setClientRole(
      ClientRole.Broadcaster,
    );
    // await _engine?.setLogFilter(LogFilter.Off);
    await _engine?.enableAudioVolumeIndication(300, 3, true);
    await _engine?.setDefaultAudioRoutetoSpeakerphone(true);
    await _engine?.setAudioProfile(
        AudioProfile.MusicHighQuality, AudioScenario.GameStreaming);
    await _engine?.joinChannelWithUserAccount(token, channelName, account);
    await _engine?.renewToken(token);
  }

  Future<void> muteLocalAudio({required bool muted}) async {
    await _engine?.muteLocalAudioStream(muted);
  }

  void setEventHandler(RtcEngineEventHandler handler) {
    _engine?.setEventHandler(handler);
  }

  Future<void> dispose() async {
    if (_engine != null) {
      await _engine?.leaveChannel();
      await _engine?.destroy();
      _engine = null;
    }
  }
}
