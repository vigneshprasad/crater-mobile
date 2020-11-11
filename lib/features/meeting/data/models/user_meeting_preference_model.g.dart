// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_meeting_preference_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserMeetingPreferenceModel _$UserMeetingPreferenceModelFromJson(
    Map<String, dynamic> json) {
  return UserMeetingPreferenceModel(
    pk: json['pk'] as int,
    user: json['user'] as String,
    meeting: json['meeting'] as int,
    numberOfMeetings: json['number_of_meetings'] as int,
    objectives: (json['objectives'] as List)?.map((e) => e as int)?.toList(),
    interests: (json['interests'] as List)?.map((e) => e as int)?.toList(),
    timeSlots: (json['time_slots'] as List)?.map((e) => e as int)?.toList(),
  );
}

Map<String, dynamic> _$UserMeetingPreferenceModelToJson(
        UserMeetingPreferenceModel instance) =>
    <String, dynamic>{
      'pk': instance.pk,
      'user': instance.user,
      'meeting': instance.meeting,
      'number_of_meetings': instance.numberOfMeetings,
      'objectives': instance.objectives,
      'interests': instance.interests,
      'time_slots': instance.timeSlots,
    };
