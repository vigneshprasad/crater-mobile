import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'dyte_meeting_model.freezed.dart';
part 'dyte_meeting_model.g.dart';

@freezed
abstract class DyteMeeting with _$DyteMeeting {
  const factory DyteMeeting({
    int? pk,
    int? dyteMeeting,
    String? authToken,
    @Default(false) bool isOnline,
    DyteMeetingDetail? dyteMeetingDetail,
  }) = _DyteMeeting;

  factory DyteMeeting.fromJson(Map<String, dynamic> json) =>
      _$DyteMeetingFromJson(json);
}

@freezed
abstract class DyteMeetingDetail with _$DyteMeetingDetail {
  const factory DyteMeetingDetail({
    // dynamic? meeting,
    int? group,
    String? dyteMeetingId,
    String? roomName,
  }) = _DyteMeetingDetail;

  factory DyteMeetingDetail.fromJson(Map<String, dynamic> json) =>
      _$DyteMeetingDetailFromJson(json);
}
