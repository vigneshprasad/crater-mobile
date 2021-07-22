import 'package:freezed_annotation/freezed_annotation.dart';

part 'conversation_rtc_info_entity.freezed.dart';
part 'conversation_rtc_info_entity.g.dart';

@freezed
abstract class ConversationRtcInfo with _$ConversationRtcInfo {
  factory ConversationRtcInfo({
    required String token,
    @JsonKey(name: "channel_name") required String channelName,
    @JsonKey(name: "rtc_uid") required String rtcUid,
  }) = _ConversationRtcInfo;

  factory ConversationRtcInfo.fromJson(Map<String, dynamic> json) =>
      _$ConversationRtcInfoFromJson(json);
}
