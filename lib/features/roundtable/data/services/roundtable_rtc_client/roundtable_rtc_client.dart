import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../core/config_reader/config_reader.dart';

final roundTableRtcClientProvider = Provider((_) => RoundTableRtcClient());

class RoundTableRtcClient {
  RtcEngine _engine;

  RoundTableRtcClient();

  RtcEngine get engine => _engine;

  Future<void> initEngine() async {
    if (_engine != null) {
      _engine = null;
    }

    // Get microphone permission
    await PermissionHandler().requestPermissions([
      PermissionGroup.microphone,
    ]);

    // Create RTC client instance
    _engine = await RtcEngine.create(ConfigReader.getAgoraAppId());
  }

  Future<void> joinRoundTableChannel(
    String channelName,
    String token,
    String account,
  ) async {
    if (_engine == null) {
      await initEngine();
    }
    await _engine.setClientRole(
      ClientRole.Broadcaster,
    );
    await _engine.setLogFilter(LogFilter.Off);
    await _engine.enableAudioVolumeIndication(300, 3, true);
    await _engine.setDefaultAudioRoutetoSpeakerphone(true);
    await _engine.setAudioProfile(
        AudioProfile.MusicHighQuality, AudioScenario.GameStreaming);
    await _engine.joinChannelWithUserAccount(token, channelName, account);
    await _engine.renewToken(token);
  }

  void setEventHandler(RtcEngineEventHandler handler) {
    _engine.setEventHandler(handler);
  }

  Future<void> renewToken(String token) async {
    await _engine.renewToken(token);
  }

  Future<void> muteLocalAudio({@required bool muted}) async {
    await _engine.muteLocalAudioStream(muted);
  }

  Future<void> dispose() async {
    await _engine.leaveChannel();
    await _engine.destroy();
    _engine = null;
  }
}
