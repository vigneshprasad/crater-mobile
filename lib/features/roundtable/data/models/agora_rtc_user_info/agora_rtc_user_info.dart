import 'package:freezed_annotation/freezed_annotation.dart';

part 'agora_rtc_user_info.freezed.dart';
part 'agora_rtc_user_info.g.dart';

@freezed
abstract class AgoraRtcUserInfo with _$AgoraRtcUserInfo {
  factory AgoraRtcUserInfo({
    String uid,
    @JsonKey(name: "user_pk") String userPk,
  }) = _AgoraRtcUserInfo;

  factory AgoraRtcUserInfo.fromJson(Map<String, dynamic> json) =>
      _$AgoraRtcUserInfoFromJson(json);
}
