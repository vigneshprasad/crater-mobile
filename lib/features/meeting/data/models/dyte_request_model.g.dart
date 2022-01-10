// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dyte_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DyteRequestModel _$DyteRequestModelFromJson(Map<String, dynamic> json) {
  return DyteRequestModel(
    token: json['token'] as String?,
    meetingDetail: json['dyte_meeting_detail'] == null
        ? null
        : DyteMeetingDetail.fromJson(
            json['dyte_meeting_detail'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$DyteRequestModelToJson(DyteRequestModel instance) =>
    <String, dynamic>{
      'token': instance.token,
      'dyte_meeting_detail': instance.meetingDetail,
    };

DyteMeetingDetail _$DyteMeetingDetailFromJson(Map<String, dynamic> json) {
  return DyteMeetingDetail(
    room: json['room_name'] as String?,
  );
}

Map<String, dynamic> _$DyteMeetingDetailToJson(DyteMeetingDetail instance) =>
    <String, dynamic>{
      'room_name': instance.room,
    };
