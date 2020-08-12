// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meeting_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Meeting _$MeetingFromJson(Map<String, dynamic> json) {
  return Meeting(
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
  );
}

Map<String, dynamic> _$MeetingToJson(Meeting instance) => <String, dynamic>{
      'pk': instance.pk,
      'title': instance.title,
      'week_start_date': instance.weekStartDate,
      'week_end_date': instance.weekEndDate,
      'is_registration_open': instance.isRegistrationOpen,
      'is_active': instance.isActive,
      'available_time_slots': instance.availableTimeSlots,
    };

UserMeetingPreference _$UserMeetingPreferenceFromJson(
    Map<String, dynamic> json) {
  return UserMeetingPreference(
    pk: json['pk'] as int,
    user: json['user'] as String,
    meeting: json['meeting'] as int,
    numberOfMeetings: json['number_of_meetings'] as int,
    objective: json['objective'] as String,
    interests: (json['interests'] as List)?.map((e) => e as int)?.toList(),
    timeSlots: (json['time_slots'] as List)?.map((e) => e as int)?.toList(),
  );
}

Map<String, dynamic> _$UserMeetingPreferenceToJson(
        UserMeetingPreference instance) =>
    <String, dynamic>{
      'pk': instance.pk,
      'user': instance.user,
      'meeting': instance.meeting,
      'number_of_meetings': instance.numberOfMeetings,
      'objective': instance.objective,
      'interests': instance.interests,
      'time_slots': instance.timeSlots,
    };

Interest _$InterestFromJson(Map<String, dynamic> json) {
  return Interest(
    pk: json['pk'] as int,
    name: json['name'] as String,
    icon: json['icon'] as String,
  );
}

Map<String, dynamic> _$InterestToJson(Interest instance) => <String, dynamic>{
      'pk': instance.pk,
      'name': instance.name,
      'icon': instance.icon,
    };

MeetingObjective _$MeetingObjectiveFromJson(Map<String, dynamic> json) {
  return MeetingObjective(
    key: json['key'] as String,
    label: json['label'] as String,
  );
}

Map<String, dynamic> _$MeetingObjectiveToJson(MeetingObjective instance) =>
    <String, dynamic>{
      'key': instance.key,
      'label': instance.label,
    };

TimeSlot _$TimeSlotFromJson(Map<String, dynamic> json) {
  return TimeSlot(
    pk: json['pk'] as int,
    end: json['end'] as String,
    start: json['start'] as String,
  );
}

Map<String, dynamic> _$TimeSlotToJson(TimeSlot instance) => <String, dynamic>{
      'pk': instance.pk,
      'end': instance.end,
      'start': instance.start,
    };
