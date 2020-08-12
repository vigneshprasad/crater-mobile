// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_api_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPostListResponse _$GetPostListResponseFromJson(Map<String, dynamic> json) {
  return GetPostListResponse(
    count: json['count'] as int,
    next: json['next'] as String,
    previous: json['previous'] as String,
    currentPage: json['current_page'] as int,
    results: (json['results'] as List)
        ?.map((e) =>
            e == null ? null : PostModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$GetPostListResponseToJson(
        GetPostListResponse instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'current_page': instance.currentPage,
      'results': instance.results,
    };
