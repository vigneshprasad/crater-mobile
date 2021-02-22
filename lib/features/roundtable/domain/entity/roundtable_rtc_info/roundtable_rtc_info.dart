import 'package:freezed_annotation/freezed_annotation.dart';

part 'roundtable_rtc_info.freezed.dart';
part 'roundtable_rtc_info.g.dart';

@freezed
abstract class RoundtableRtcInfo with _$RoundtableRtcInfo {
  factory RoundtableRtcInfo({
    String token,
    @JsonKey(name: "channel_name") String channelName,
    @JsonKey(name: "rtc_uid") String rtcUid,
  }) = _RoundtableRtcInfo;

  factory RoundtableRtcInfo.fromJson(Map<String, dynamic> json) =>
      _$RoundtableRtcInfoFromJson(json);
}
