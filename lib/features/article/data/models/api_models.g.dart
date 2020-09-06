// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticlesPageApiResponse _$ArticlesPageApiResponseFromJson(
    Map<String, dynamic> json) {
  return ArticlesPageApiResponse(
    count: json['count'] as int,
    currentPage: json['current_page'] as int,
    next: json['next'] as String,
    pages: json['pages'] as int,
    previous: json['previous'] as String,
    results: (json['results'] as List)
        ?.map((e) =>
            e == null ? null : ArticleModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ArticlesPageApiResponseToJson(
        ArticlesPageApiResponse instance) =>
    <String, dynamic>{
      'count': instance.count,
      'current_page': instance.currentPage,
      'next': instance.next,
      'pages': instance.pages,
      'previous': instance.previous,
      'results': instance.results,
    };
