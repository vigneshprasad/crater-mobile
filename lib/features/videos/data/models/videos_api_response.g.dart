// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'videos_api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideosApiResponse _$VideosApiResponseFromJson(Map<String, dynamic> json) {
  return VideosApiResponse(
    count: json['count'] as int,
    next: json['next'] as String,
    previous: json['previous'] as String,
    results: (json['results'] as List<dynamic>)
        .map((e) => VideoModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$VideosApiResponseToJson(VideosApiResponse instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results,
    };
