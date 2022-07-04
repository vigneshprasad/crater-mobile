// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'webinar_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_WebinarRequest _$_$_WebinarRequestFromJson(Map<String, dynamic> json) {
  return _$_WebinarRequest(
    description: json['description'] as String?,
    start: json['start'] as String,
    categories:
        (json['categories'] as List<dynamic>).map((e) => e as int).toList(),
    title: json['topic_title'] as String,
    coverImage: json['topic_image'] as String,
    rtmpLink: json['rtmp_link'] as String?,
  );
}

Map<String, dynamic> _$_$_WebinarRequestToJson(_$_WebinarRequest instance) =>
    <String, dynamic>{
      'description': instance.description,
      'start': instance.start,
      'categories': instance.categories,
      'topic_title': instance.title,
      'topic_image': instance.coverImage,
      'rtmp_link': instance.rtmpLink,
    };
