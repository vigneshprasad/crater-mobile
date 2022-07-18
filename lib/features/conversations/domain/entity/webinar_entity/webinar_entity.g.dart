// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'webinar_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Webinar _$$_WebinarFromJson(Map<String, dynamic> json) => _$_Webinar(
      id: json['id'] as int?,
      host: json['host'] as String?,
      description: json['description'] as String?,
      start: json['start'] == null
          ? null
          : DateTime.parse(json['start'] as String),
      privacy: json['privacy'] as int?,
      medium: json['medium'] as int?,
      closed: json['closed'] as bool?,
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
      type: json['type'] as int?,
      isLive: json['is_live'] as bool?,
      isPast: json['is_past'] as bool?,
      recordingDetails: json['recording_details'] == null
          ? null
          : RecordingDetails.fromJson(
              json['recording_details'] as Map<String, dynamic>),
      liveCount: json['liveCount'] as int?,
      rsvp: json['rsvp'] as bool?,
    );

Map<String, dynamic> _$$_WebinarToJson(_$_Webinar instance) =>
    <String, dynamic>{
      'id': instance.id,
      'host': instance.host,
      'description': instance.description,
      'start': instance.start?.toIso8601String(),
      'privacy': instance.privacy,
      'medium': instance.medium,
      'closed': instance.closed,
      'closed_at': instance.closedAt?.toIso8601String(),
      'topic_detail': instance.topicDetail,
      'host_detail': instance.hostDetail,
      'type': instance.type,
      'is_live': instance.isLive,
      'is_past': instance.isPast,
      'recording_details': instance.recordingDetails,
      'liveCount': instance.liveCount,
      'rsvp': instance.rsvp,
    };
