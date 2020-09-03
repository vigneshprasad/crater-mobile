// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostsPageApiResponse _$PostsPageApiResponseFromJson(Map<String, dynamic> json) {
  return PostsPageApiResponse(
    count: json['count'] as int,
    currentPage: json['current_page'] as int,
    next: json['next'] as String,
    previous: json['previous'] as String,
    results: (json['results'] as List)
        ?.map((e) =>
            e == null ? null : PostModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$PostsPageApiResponseToJson(
        PostsPageApiResponse instance) =>
    <String, dynamic>{
      'count': instance.count,
      'current_page': instance.currentPage,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results,
    };
