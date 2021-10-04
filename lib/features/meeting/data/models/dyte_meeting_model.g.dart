// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dyte_meeting_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DyteMeeting _$_$_DyteMeetingFromJson(Map<String, dynamic> json) {
  return _$_DyteMeeting(
    pk: json['pk'] as int?,
    dyteMeeting: json['dyteMeeting'] as int?,
    authToken: json['authToken'] as String?,
    isOnline: json['isOnline'] as bool? ?? false,
    dyteMeetingDetail: json['dyteMeetingDetail'] == null
        ? null
        : DyteMeetingDetail.fromJson(
            json['dyteMeetingDetail'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$_$_DyteMeetingToJson(_$_DyteMeeting instance) =>
    <String, dynamic>{
      'pk': instance.pk,
      'dyteMeeting': instance.dyteMeeting,
      'authToken': instance.authToken,
      'isOnline': instance.isOnline,
      'dyteMeetingDetail': instance.dyteMeetingDetail,
    };

_$_DyteMeetingDetail _$_$_DyteMeetingDetailFromJson(Map<String, dynamic> json) {
  return _$_DyteMeetingDetail(
    group: json['group'] as int?,
    dyteMeetingId: json['dyteMeetingId'] as String?,
    roomName: json['roomName'] as String?,
  );
}

Map<String, dynamic> _$_$_DyteMeetingDetailToJson(
        _$_DyteMeetingDetail instance) =>
    <String, dynamic>{
      'group': instance.group,
      'dyteMeetingId': instance.dyteMeetingId,
      'roomName': instance.roomName,
    };
