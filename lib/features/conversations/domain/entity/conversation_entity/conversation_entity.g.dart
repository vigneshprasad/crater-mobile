// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Conversation _$_$_ConversationFromJson(Map<String, dynamic> json) {
  return _$_Conversation(
    id: json['id'] as int,
    host: json['host'] as String,
    speakers: (json['speakers'] as List)?.map((e) => e as String)?.toList(),
    topic: json['topic'] as int,
    description: json['description'] as String,
    interests: (json['interests'] as List)?.map((e) => e as int)?.toList(),
    start:
        json['start'] == null ? null : DateTime.parse(json['start'] as String),
    end: json['end'] == null ? null : DateTime.parse(json['end'] as String),
    maxSpeakers: json['max_speakers'] as int,
    privacy: json['privacy'] as int,
    medium: json['medium'] as int,
    closed: json['closed'] as bool,
    closedAt: json['closed_at'] == null
        ? null
        : DateTime.parse(json['closed_at'] as String),
    topicDetail: json['topic_detail'] == null
        ? null
        : Topic.fromJson(json['topic_detail'] as Map<String, dynamic>),
    hostDetail: json['host_detail'] == null
        ? null
        : ConversationUser.fromJson(
            json['host_detail'] as Map<String, dynamic>),
    interestsDetailList: (json['interests_detail_list'] as List)
        ?.map((e) => e == null
            ? null
            : MeetingInterestModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    speakersDetailList: (json['speakers_detail_list'] as List)
        ?.map((e) => e == null
            ? null
            : ConversationUser.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    isSpeaker: json['is_speaker'] as bool,
  );
}

Map<String, dynamic> _$_$_ConversationToJson(_$_Conversation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'host': instance.host,
      'speakers': instance.speakers,
      'topic': instance.topic,
      'description': instance.description,
      'interests': instance.interests,
      'start': instance.start?.toIso8601String(),
      'end': instance.end?.toIso8601String(),
      'max_speakers': instance.maxSpeakers,
      'privacy': instance.privacy,
      'medium': instance.medium,
      'closed': instance.closed,
      'closed_at': instance.closedAt?.toIso8601String(),
      'topic_detail': instance.topicDetail,
      'host_detail': instance.hostDetail,
      'interests_detail_list': instance.interestsDetailList,
      'speakers_detail_list': instance.speakersDetailList,
      'is_speaker': instance.isSpeaker,
    };

_$_ConversationUser _$_$_ConversationUserFromJson(Map<String, dynamic> json) {
  return _$_ConversationUser(
    pk: json['pk'] as String,
    email: json['email'] as String,
    name: json['name'] as String,
    photo: json['photo'] as String,
    introduction: json['introduction'] as String,
  );
}

Map<String, dynamic> _$_$_ConversationUserToJson(
        _$_ConversationUser instance) =>
    <String, dynamic>{
      'pk': instance.pk,
      'email': instance.email,
      'name': instance.name,
      'photo': instance.photo,
      'introduction': instance.introduction,
    };

_$_ConversationByDate _$_$_ConversationByDateFromJson(
    Map<String, dynamic> json) {
  return _$_ConversationByDate(
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
    conversations: (json['conversations'] as List)
        ?.map((e) =>
            e == null ? null : Conversation.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$_$_ConversationByDateToJson(
        _$_ConversationByDate instance) =>
    <String, dynamic>{
      'date': instance.date?.toIso8601String(),
      'conversations': instance.conversations,
    };
