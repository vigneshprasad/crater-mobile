// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Article _$_$_ArticleFromJson(Map<String, dynamic> json) {
  return _$_Article(
    pk: json['pk'] as int,
    title: json['title'] as String?,
    description: json['description'] as String?,
    image: json['image'] as String?,
    tag: json['tag'] as String?,
    websiteTag: json['website_tag'] as String?,
    websiteUrl: json['website_url'] as String?,
    articleSourceDetail: json['website_tag_detail'] == null
        ? null
        : ArticleWebsiteSource.fromJson(
            json['website_tag_detail'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$_$_ArticleToJson(_$_Article instance) =>
    <String, dynamic>{
      'pk': instance.pk,
      'title': instance.title,
      'description': instance.description,
      'image': instance.image,
      'tag': instance.tag,
      'website_tag': instance.websiteTag,
      'website_url': instance.websiteUrl,
      'website_tag_detail': instance.articleSourceDetail,
    };
