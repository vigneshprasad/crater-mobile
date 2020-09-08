// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetMeetingConfigApiResponse _$GetMeetingConfigApiResponseFromJson(
    Map<String, dynamic> json) {
  return GetMeetingConfigApiResponse(
    pk: json['pk'] as int,
    title: json['title'] as String,
    interests: (json['interests'] as List)
        ?.map((e) => e == null
            ? null
            : MeetingInterestModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    objectives: (json['objectives'] as List)
        ?.map((e) => e == null
            ? null
            : MeetingObjectiveModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    isActive: json['is_active'] as bool,
    availableTimeSlots:
        (json['available_time_slots'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(
          k,
          (e as List)
              ?.map((e) => e == null
                  ? null
                  : TimeSlotModel.fromJson(e as Map<String, dynamic>))
              ?.toList()),
    ),
    weekEndDate: json['week_end_date'] as String,
    weekStartDate: json['week_start_date'] as String,
    isRegistrationOpen: json['is_registration_open'] as bool,
    userPreferences: json['user_preferences'] == null
        ? null
        : UserMeetingPreferenceModel.fromJson(
            json['user_preferences'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GetMeetingConfigApiResponseToJson(
        GetMeetingConfigApiResponse instance) =>
    <String, dynamic>{
      'pk': instance.pk,
      'title': instance.title,
      'interests': instance.interests,
      'objectives': instance.objectives,
      'is_active': instance.isActive,
      'available_time_slots': instance.availableTimeSlots,
      'week_end_date': instance.weekEndDate,
      'week_start_date': instance.weekStartDate,
      'is_registration_open': instance.isRegistrationOpen,
      'user_preferences': instance.userPreferences,
    };
