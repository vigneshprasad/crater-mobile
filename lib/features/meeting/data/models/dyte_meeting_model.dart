import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

// part 'dyte_meeting_model.freezed.dart';
part 'dyte_meeting_model.g.dart';

@JsonSerializable()
class DyteMeeting {
  int? pk;
  @JsonKey(name: 'dyte_meeting')
  final int? dyteMeeting;
  @JsonKey(name: 'auth_token')
  final String? authToken;
  @JsonKey(name: 'is_online')
  @Default(false)
  final bool? isOnline;
  @JsonKey(name: 'dyte_meeting_detail')
  final DyteMeetingDetail? dyteMeetingDetail;

  DyteMeeting({
    this.dyteMeeting,
    this.authToken,
    this.isOnline = false,
    this.dyteMeetingDetail,
  });

  factory DyteMeeting.fromJson(Map<String, dynamic> json) =>
      _$DyteMeetingFromJson(json);

  Map<String, dynamic> toJson() => _$DyteMeetingToJson(this);
}

@JsonSerializable()
class DyteMeetingDetail {
  final int? group;
  @JsonKey(name: 'dyte_meeting_id')
  final String? dyteMeetingId;
  @JsonKey(name: 'room_name')
  final String? roomName;

  DyteMeetingDetail({
    this.group,
    this.dyteMeetingId,
    this.roomName,
  });

  factory DyteMeetingDetail.fromJson(Map<String, dynamic> json) =>
      _$DyteMeetingDetailFromJson(json);

  Map<String, dynamic> toJson() => _$DyteMeetingDetailToJson(this);
}
