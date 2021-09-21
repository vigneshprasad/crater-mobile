// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'webinar_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Webinar _$_$_WebinarFromJson(Map<String, dynamic> json) {
  return _$_Webinar(
    id: json['id'] as int?,
    host: json['host'] as String?,
    description: json['description'] as String?,
    start:
        json['start'] == null ? null : DateTime.parse(json['start'] as String),
    privacy: json['privacy'] as int?,
    medium: json['medium'] as int?,
    closed: json['closed'] as bool?,
    closedAt: json['closedAt'] == null
        ? null
        : DateTime.parse(json['closedAt'] as String),
    topicDetail: json['topic_detail'] == null
        ? null
        : Topic.fromJson(json['topic_detail'] as Map<String, dynamic>),
    hostDetail: json['host_detail'] == null
        ? null
        : ConversationUser.fromJson(
            json['host_detail'] as Map<String, dynamic>),
    type: json['type'] as int?,
    isLive: json['isLive'] as bool?,
    liveCount: json['liveCount'] as int?,
    rsvp: json['rsvp'] as bool?,
  );
}

Map<String, dynamic> _$_$_WebinarToJson(_$_Webinar instance) =>
    <String, dynamic>{
      'id': instance.id,
      'host': instance.host,
      'description': instance.description,
      'start': instance.start?.toIso8601String(),
      'privacy': instance.privacy,
      'medium': instance.medium,
      'closed': instance.closed,
      'closedAt': instance.closedAt?.toIso8601String(),
      'topic_detail': instance.topicDetail,
      'host_detail': instance.hostDetail,
      'type': instance.type,
      'isLive': instance.isLive,
      'liveCount': instance.liveCount,
      'rsvp': instance.rsvp,
    };
