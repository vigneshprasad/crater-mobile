// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Profile _$_$_ProfileFromJson(Map<String, dynamic> json) {
  return _$_Profile(
    pk: json['pk'] as int,
    name: json['name'] as String,
    introduction: json['introduction'] as String,
    generatedIntroduction: json['generated_introduction'] as String,
    tag: (json['tag_list'] as List)
        ?.map((e) => e == null ? null : Tag.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    linkedIn: json['linkedin_url'] as String,
    photo: json['photo'] as String,
  );
}

Map<String, dynamic> _$_$_ProfileToJson(_$_Profile instance) =>
    <String, dynamic>{
      'pk': instance.pk,
      'name': instance.name,
      'introduction': instance.introduction,
      'generated_introduction': instance.generatedIntroduction,
      'tag_list': instance.tag,
      'linkedin_url': instance.linkedIn,
      'photo': instance.photo,
    };
