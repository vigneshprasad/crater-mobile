import 'package:freezed_annotation/freezed_annotation.dart';

part 'conversation_rtc_info_entity.freezed.dart';
part 'conversation_rtc_info_entity.g.dart';

@freezed
abstract class ConversationRtcInfo with _$ConversationRtcInfo {
  factory ConversationRtcInfo({
    String token,
    @JsonKey(name: "channel_name") String channelName,
    @JsonKey(name: "rtc_uid") String rtcUid,
  }) = _ConversationRtcInfo;

  factory ConversationRtcInfo.fromJson(Map<String, dynamic> json) =>
      _$ConversationRtcInfoFromJson(json);
}
