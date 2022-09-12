// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Profile _$$_ProfileFromJson(Map<String, dynamic> json) => _$_Profile(
      pk: json['pk'] as int?,
      uuid: json['uuid'] as String?,
      name: json['name'] as String?,
      introduction: json['introduction'] as String?,
      generatedIntroduction: json['generated_introduction'] as String?,
      tag: (json['tag_list'] as List<dynamic>?)
          ?.map((e) => Tag.fromJson(e as Map<String, dynamic>))
          .toList(),
      linkedIn: json['linkedin_url'] as String?,
      photo: json['photo'] as String?,
      allowMeetingRequest: json['allow_meeting_request'] as bool?,
      canConnect: json['can_connect'] as bool?,
    );

Map<String, dynamic> _$$_ProfileToJson(_$_Profile instance) =>
    <String, dynamic>{
      'pk': instance.pk,
      'uuid': instance.uuid,
      'name': instance.name,
      'introduction': instance.introduction,
      'generated_introduction': instance.generatedIntroduction,
      'tag_list': instance.tag,
      'linkedin_url': instance.linkedIn,
      'photo': instance.photo,
      'allow_meeting_request': instance.allowMeetingRequest,
      'can_connect': instance.canConnect,
    };
