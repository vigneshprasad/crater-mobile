// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meets_api_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeetingsResponse _$MeetingsResponseFromJson(Map<String, dynamic> json) {
  return MeetingsResponse(
    pk: json['pk'] as int,
    title: json['title'] as String,
    weekStartDate: json['week_start_date'] as String,
    weekEndDate: json['week_end_date'] as String,
    isRegistrationOpen: json['is_registration_open'] as bool,
    isActive: json['is_active'] as bool,
    availableTimeSlots:
        (json['available_time_slots'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(
          k,
          (e as List)
              ?.map((e) => e == null
                  ? null
                  : TimeSlot.fromJson(e as Map<String, dynamic>))
              ?.toList()),
    ),
    objectives: (json['objectives'] as List)
        ?.map((e) => e == null
            ? null
            : MeetingObjective.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    interests: (json['interests'] as List)
        ?.map((e) =>
            e == null ? null : Interest.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    userPreferences: json['user_preferences'] == null
        ? null
        : UserMeetingPreference.fromJson(
            json['user_preferences'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$MeetingsResponseToJson(MeetingsResponse instance) =>
    <String, dynamic>{
      'pk': instance.pk,
      'title': instance.title,
      'week_start_date': instance.weekStartDate,
      'week_end_date': instance.weekEndDate,
      'is_registration_open': instance.isRegistrationOpen,
      'is_active': instance.isActive,
      'available_time_slots': instance.availableTimeSlots,
      'objectives': instance.objectives,
      'interests': instance.interests,
      'user_preferences': instance.userPreferences,
    };
