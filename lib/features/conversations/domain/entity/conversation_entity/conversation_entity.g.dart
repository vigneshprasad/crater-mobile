// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Conversation _$_$_ConversationFromJson(Map<String, dynamic> json) {
  return _$_Conversation(
    id: json['id'] as int?,
    host: json['host'] as String?,
    speakers:
        (json['speakers'] as List<dynamic>?)?.map((e) => e as String).toList(),
    attendees:
        (json['attendees'] as List<dynamic>?)?.map((e) => e as String).toList(),
    topic: json['topic'] as int?,
    description: json['description'] as String?,
    interests:
        (json['interests'] as List<dynamic>?)?.map((e) => e as int).toList(),
    start:
        json['start'] == null ? null : DateTime.parse(json['start'] as String),
    end: json['end'] == null ? null : DateTime.parse(json['end'] as String),
    maxSpeakers: json['max_speakers'] as int?,
    privacy:
        _$enumDecodeNullable(_$ConversationPrivacyEnumMap, json['privacy']),
    medium: _$enumDecodeNullable(_$ConversationMediumEnumMap, json['medium']),
    closed: json['closed'] as bool?,
    relevancy: json['relevancy'] as int?,
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
    interestsDetailList: (json['interests_detail_list'] as List<dynamic>?)
        ?.map((e) => MeetingInterestModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    speakersDetailList: (json['speakers_detail_list'] as List<dynamic>?)
        ?.map((e) => ConversationUser.fromJson(e as Map<String, dynamic>))
        .toList(),
    attendeesDetailList: (json['attendees_detail_list'] as List<dynamic>?)
        ?.map((e) => ConversationUser.fromJson(e as Map<String, dynamic>))
        .toList(),
    isSpeaker: json['is_speaker'] as bool?,
    isPast: json['is_past'] as bool?,
  );
}

Map<String, dynamic> _$_$_ConversationToJson(_$_Conversation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'host': instance.host,
      'speakers': instance.speakers,
      'attendees': instance.attendees,
      'topic': instance.topic,
      'description': instance.description,
      'interests': instance.interests,
      'start': instance.start?.toIso8601String(),
      'end': instance.end?.toIso8601String(),
      'max_speakers': instance.maxSpeakers,
      'privacy': _$ConversationPrivacyEnumMap[instance.privacy],
      'medium': _$ConversationMediumEnumMap[instance.medium],
      'closed': instance.closed,
      'relevancy': instance.relevancy,
      'closed_at': instance.closedAt?.toIso8601String(),
      'topic_detail': instance.topicDetail,
      'host_detail': instance.hostDetail,
      'interests_detail_list': instance.interestsDetailList,
      'speakers_detail_list': instance.speakersDetailList,
      'attendees_detail_list': instance.attendeesDetailList,
      'is_speaker': instance.isSpeaker,
      'is_past': instance.isPast,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

K? _$enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<K, V>(enumValues, source, unknownValue: unknownValue);
}

const _$ConversationPrivacyEnumMap = {
  ConversationPrivacy.public: 0,
  ConversationPrivacy.private: 1,
};

const _$ConversationMediumEnumMap = {
  ConversationMedium.audio: 0,
  ConversationMedium.audioVideo: 1,
};

_$_ConversationUser _$_$_ConversationUserFromJson(Map<String, dynamic> json) {
  return _$_ConversationUser(
    pk: json['pk'] as String?,
    email: json['email'] as String?,
    name: json['name'] as String?,
    photo: json['photo'] as String?,
    introduction: json['introduction'] as String?,
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
    conversations: (json['conversations'] as List<dynamic>?)
        ?.map((e) => Conversation.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$_$_ConversationByDateToJson(
        _$_ConversationByDate instance) =>
    <String, dynamic>{
      'date': instance.date?.toIso8601String(),
      'conversations': instance.conversations,
    };
