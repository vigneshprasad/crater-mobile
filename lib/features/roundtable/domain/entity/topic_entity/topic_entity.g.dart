// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Topic _$_$_TopicFromJson(Map<String, dynamic> json) {
  return _$_Topic(
    id: json['id'] as int,
    name: json['name'] as String,
    image: json['image'] as String,
    active: json['is_active'] as bool,
    parent: json['parent'] as int,
    description: json['description'] as String,
    approved: json['is_approved'] as bool,
    creator: json['creator'] as String,
    root: json['root'] == null
        ? null
        : Topic.fromJson(json['root'] as Map<String, dynamic>),
    groupCount: json['groupCount'] as int,
  );
}

Map<String, dynamic> _$_$_TopicToJson(_$_Topic instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'is_active': instance.active,
      'parent': instance.parent,
      'description': instance.description,
      'is_approved': instance.approved,
      'creator': instance.creator,
      'root': instance.root,
      'groupCount': instance.groupCount,
    };
