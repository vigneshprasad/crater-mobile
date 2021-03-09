// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'optin_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Optin _$_$_OptinFromJson(Map<String, dynamic> json) {
  return _$_Optin(
    pk: json['pk'] as int,
    user: json['user'] as String,
    meeting: json['meeting'] as int,
    numberOfMeetings: json['number_of_meetings'] as int,
    numberOfMeetingsPerMonth: json['number_of_meetings_per_month'] as int,
    objectives: (json['objectives'] as List)
        ?.map((e) => e == null
            ? null
            : MeetingObjectiveModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    interests: (json['interests'] as List)
        ?.map((e) => e == null
            ? null
            : MeetingInterestModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    timeSlots: (json['time_slots'] as List)
        ?.map((e) => e == null
            ? null
            : TimeSlotModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$_$_OptinToJson(_$_Optin instance) => <String, dynamic>{
      'pk': instance.pk,
      'user': instance.user,
      'meeting': instance.meeting,
      'number_of_meetings': instance.numberOfMeetings,
      'number_of_meetings_per_month': instance.numberOfMeetingsPerMonth,
      'objectives': instance.objectives,
      'interests': instance.interests,
      'time_slots': instance.timeSlots,
    };
