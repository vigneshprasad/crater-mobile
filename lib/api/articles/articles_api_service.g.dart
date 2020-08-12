// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'articles_api_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetArticlesListResponse _$GetArticlesListResponseFromJson(
    Map<String, dynamic> json) {
  return GetArticlesListResponse(
    count: json['count'] as int,
    currentPage: json['current_page'] as int,
    next: json['next'] as String,
    pages: json['pages'] as int,
    previous: json['previous'] as String,
    results: (json['results'] as List)
        ?.map((e) =>
            e == null ? null : Article.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$GetArticlesListResponseToJson(
        GetArticlesListResponse instance) =>
    <String, dynamic>{
      'count': instance.count,
      'current_page': instance.currentPage,
      'next': instance.next,
      'pages': instance.pages,
      'previous': instance.previous,
      'results': instance.results,
    };
