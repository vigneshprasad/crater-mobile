// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'roundtable_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RoundTable _$_$_RoundTableFromJson(Map<String, dynamic> json) {
  return _$_RoundTable(
    id: json['id'] as int,
    host: json['host'] == null
        ? null
        : Host.fromJson(json['host'] as Map<String, dynamic>),
    speakers: (json['speakers'] as List)
        ?.map((e) =>
            e == null ? null : Speaker.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    agenda: json['agenda'] == null
        ? null
        : Agenda.fromJson(json['agenda'] as Map<String, dynamic>),
    description: json['description'] as String,
    interests: (json['interests'] as List)
        ?.map((e) => e == null
            ? null
            : MeetingInterestModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
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
  );
}

Map<String, dynamic> _$_$_RoundTableToJson(_$_RoundTable instance) =>
    <String, dynamic>{
      'id': instance.id,
      'host': instance.host,
      'speakers': instance.speakers,
      'agenda': instance.agenda,
      'description': instance.description,
      'interests': instance.interests,
      'start': instance.start?.toIso8601String(),
      'end': instance.end?.toIso8601String(),
      'max_speakers': instance.maxSpeakers,
      'privacy': instance.privacy,
      'medium': instance.medium,
      'closed': instance.closed,
      'closed_at': instance.closedAt?.toIso8601String(),
    };

_$_Speaker _$_$_SpeakerFromJson(Map<String, dynamic> json) {
  return _$_Speaker(
    pk: json['pk'] as String,
    email: json['email'] as String,
    name: json['name'] as String,
    photo: json['photo'] as String,
  );
}

Map<String, dynamic> _$_$_SpeakerToJson(_$_Speaker instance) =>
    <String, dynamic>{
      'pk': instance.pk,
      'email': instance.email,
      'name': instance.name,
      'photo': instance.photo,
    };

_$_Host _$_$_HostFromJson(Map<String, dynamic> json) {
  return _$_Host(
    pk: json['pk'] as String,
    email: json['email'] as String,
    name: json['name'] as String,
    photo: json['photo'] as String,
  );
}

Map<String, dynamic> _$_$_HostToJson(_$_Host instance) => <String, dynamic>{
      'pk': instance.pk,
      'email': instance.email,
      'name': instance.name,
      'photo': instance.photo,
    };
