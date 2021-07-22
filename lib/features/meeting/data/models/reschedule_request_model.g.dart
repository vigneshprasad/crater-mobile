// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reschedule_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RescheduleRequestModel _$RescheduleRequestModelFromJson(
    Map<String, dynamic> json) {
  return RescheduleRequestModel(
    id: json['id'] as int,
    oldMeeting: json['old_meeting'] as int?,
    timeSlots: (json['time_slots'] as List<dynamic>?)
        ?.map((e) => DateTime.parse(e as String))
        .toList(),
    requestedBy: json['requested_by'] as String?,
  );
}

Map<String, dynamic> _$RescheduleRequestModelToJson(
        RescheduleRequestModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'old_meeting': instance.oldMeeting,
      'time_slots':
          instance.timeSlots?.map((e) => e.toIso8601String()).toList(),
      'requested_by': instance.requestedBy,
    };
