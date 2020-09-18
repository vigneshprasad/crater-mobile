// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllNotificationsPageResponse _$GetAllNotificationsPageResponseFromJson(
    Map<String, dynamic> json) {
  return GetAllNotificationsPageResponse(
    count: json['count'] as int,
    currentPage: json['current_page'] as int,
    next: json['next'] as String,
    pages: json['pages'] as int,
    results: (json['results'] as List)
        ?.map((e) => e == null
            ? null
            : NotificationModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$GetAllNotificationsPageResponseToJson(
        GetAllNotificationsPageResponse instance) =>
    <String, dynamic>{
      'count': instance.count,
      'current_page': instance.currentPage,
      'next': instance.next,
      'pages': instance.pages,
      'results': instance.results,
    };
