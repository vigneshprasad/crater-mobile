// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dyte_meeting_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DyteMeeting _$DyteMeetingFromJson(Map<String, dynamic> json) => DyteMeeting(
      dyteMeeting: json['dyte_meeting'] as int?,
      authToken: json['auth_token'] as String?,
      isOnline: json['is_online'] as bool? ?? false,
      dyteMeetingDetail: json['dyte_meeting_detail'] == null
          ? null
          : DyteMeetingDetail.fromJson(
              json['dyte_meeting_detail'] as Map<String, dynamic>),
    )..pk = json['pk'] as int?;

Map<String, dynamic> _$DyteMeetingToJson(DyteMeeting instance) =>
    <String, dynamic>{
      'pk': instance.pk,
      'dyte_meeting': instance.dyteMeeting,
      'auth_token': instance.authToken,
      'is_online': instance.isOnline,
      'dyte_meeting_detail': instance.dyteMeetingDetail,
    };

DyteMeetingDetail _$DyteMeetingDetailFromJson(Map<String, dynamic> json) =>
    DyteMeetingDetail(
      group: json['group'] as int?,
      dyteMeetingId: json['dyte_meeting_id'] as String?,
      roomName: json['room_name'] as String?,
    );

Map<String, dynamic> _$DyteMeetingDetailToJson(DyteMeetingDetail instance) =>
    <String, dynamic>{
      'group': instance.group,
      'dyte_meeting_id': instance.dyteMeetingId,
      'room_name': instance.roomName,
    };
