import 'package:json_annotation/json_annotation.dart';

part 'dyte_request_model.g.dart';

// ignore_for_file: annotate_overrides
// ignore_for_file: overridden_fields

@JsonSerializable()
class DyteRequestModel {
  final String? token;

  @JsonKey(name: 'dyte_meeting_detail')
  final DyteMeetingDetail? meetingDetail;

  DyteRequestModel({
    this.token,
    this.meetingDetail,
  });

  factory DyteRequestModel.fromJson(Map<String, dynamic> json) =>
      _$DyteRequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$DyteRequestModelToJson(this);
}

@JsonSerializable()
class DyteMeetingDetail {
  @JsonKey(name: 'room_name')
  final String? room;

  DyteMeetingDetail({
    this.room,
  });

  factory DyteMeetingDetail.fromJson(Map<String, dynamic> json) =>
      _$DyteMeetingDetailFromJson(json);
  Map<String, dynamic> toJson() => _$DyteMeetingDetailToJson(this);
}
