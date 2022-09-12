// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Topic _$$_TopicFromJson(Map<String, dynamic> json) => _$_Topic(
      id: json['id'] as int?,
      name: json['name'] as String?,
      image: json['image'] as String?,
      active: json['is_active'] as bool?,
      parent: json['parent'] as int?,
      description: json['description'] as String?,
      article: json['article'] as int?,
      approved: json['is_approved'] as bool?,
      creator: json['creator'] as String?,
      root: json['root'] == null
          ? null
          : Topic.fromJson(json['root'] as Map<String, dynamic>),
      groupCount: json['groupCount'] as int?,
      type: $enumDecodeNullable(_$TopicTypeEnumMap, json['type']),
      articleDetail: json['article_detail'] == null
          ? null
          : Article.fromJson(json['article_detail'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_TopicToJson(_$_Topic instance) => <String, dynamic>{
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

const _$TopicTypeEnumMap = {
  TopicType.group: 'group',
  TopicType.ama: 'ama',
};

_$_Article _$$_ArticleFromJson(Map<String, dynamic> json) => _$_Article(
      pk: json['pk'] as int?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      tag: json['tag'] as String?,
      websiteTag: json['website_tag'] as String?,
      websiteUrl: json['website_url'] as String?,
    );

Map<String, dynamic> _$$_ArticleToJson(_$_Article instance) =>
    <String, dynamic>{
      'pk': instance.pk,
      'title': instance.title,
      'description': instance.description,
      'image': instance.image,
      'tag': instance.tag,
      'website_tag': instance.websiteTag,
      'website_url': instance.websiteUrl,
    };
