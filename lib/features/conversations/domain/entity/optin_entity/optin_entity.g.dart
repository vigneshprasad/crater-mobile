// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'optin_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Optin _$_$_OptinFromJson(Map<String, dynamic> json) {
  return _$_Optin(
    pk: json['pk'] as int?,
    user: json['user'] as String?,
    meeting: json['meeting'] as int?,
    topic: json['topic'] as int?,
    topicDetail: json['topic_detail'] == null
        ? null
        : Topic.fromJson(json['topic_detail'] as Map<String, dynamic>),
    numberOfMeetings: json['number_of_meetings'] as int?,
    numberOfMeetingsPerMonth: json['number_of_meetings_per_month'] as int?,
    objectives:
        (json['objectives'] as List<dynamic>?)?.map((e) => e as int).toList(),
    interests:
        (json['interests'] as List<dynamic>?)?.map((e) => e as int).toList(),
    interestList: (json['interest_list'] as List<dynamic>?)
        ?.map((e) => MeetingInterestModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    timeSlots:
        (json['time_slots'] as List<dynamic>?)?.map((e) => e as int).toList(),
    timeSlotList: (json['time_slot_list'] as List<dynamic>?)
        ?.map((e) => TimeSlotModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$_$_OptinToJson(_$_Optin instance) => <String, dynamic>{
      'pk': instance.pk,
      'user': instance.user,
      'meeting': instance.meeting,
      'topic': instance.topic,
      'topic_detail': instance.topicDetail,
      'number_of_meetings': instance.numberOfMeetings,
      'number_of_meetings_per_month': instance.numberOfMeetingsPerMonth,
      'objectives': instance.objectives,
      'interests': instance.interests,
      'interest_list': instance.interestList,
      'time_slots': instance.timeSlots,
      'time_slot_list': instance.timeSlotList,
    };

_$_OptinsByDate _$_$_OptinsByDateFromJson(Map<String, dynamic> json) {
  return _$_OptinsByDate(
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
    optins: (json['optins'] as List<dynamic>?)
        ?.map((e) => Optin.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$_$_OptinsByDateToJson(_$_OptinsByDate instance) =>
    <String, dynamic>{
      'date': instance.date?.toIso8601String(),
      'optins': instance.optins,
    };
