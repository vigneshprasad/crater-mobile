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
    article: json['article'] as int,
    approved: json['is_approved'] as bool,
    creator: json['creator'] as String,
    root: json['root'] == null
        ? null
        : Topic.fromJson(json['root'] as Map<String, dynamic>),
    groupCount: json['groupCount'] as int,
    type: _$enumDecodeNullable(_$TopicTypeEnumMap, json['type']),
    articleDetail: json['article_detail'] == null
        ? null
        : Article.fromJson(json['article_detail'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$_$_TopicToJson(_$_Topic instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'is_active': instance.active,
      'parent': instance.parent,
      'description': instance.description,
      'article': instance.article,
      'is_approved': instance.approved,
      'creator': instance.creator,
      'root': instance.root,
      'groupCount': instance.groupCount,
      'type': _$TopicTypeEnumMap[instance.type],
      'article_detail': instance.articleDetail,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$TopicTypeEnumMap = {
  TopicType.group: 'group',
  TopicType.ama: 'ama',
};
