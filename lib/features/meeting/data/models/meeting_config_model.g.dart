// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meeting_config_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeetingConfigModel _$MeetingConfigModelFromJson(Map<String, dynamic> json) {
  return MeetingConfigModel(
    pk: json['pk'] as int?,
    title: json['title'] as String?,
    weekStartDate: json['week_start_date'] as String?,
    weekEndDate: json['week_end_date'] as String?,
    isRegistrationOpen: json['is_registration_open'] as bool?,
    isActive: json['is_active'] as bool?,
    availableTimeSlots:
        (json['available_time_slots'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(
          k,
          (e as List<dynamic>)
              .map((e) => TimeSlotModel.fromJson(e as Map<String, dynamic>))
              .toList()),
    ),
  );
}

Map<String, dynamic> _$MeetingConfigModelToJson(MeetingConfigModel instance) =>
    <String, dynamic>{
      'pk': instance.pk,
      'title': instance.title,
      'week_start_date': instance.weekStartDate,
      'week_end_date': instance.weekEndDate,
      'is_registration_open': instance.isRegistrationOpen,
      'is_active': instance.isActive,
      'available_time_slots': instance.availableTimeSlots,
    };
