// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'masterclass_api_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MasterClassGetResponse _$MasterClassGetResponseFromJson(
    Map<String, dynamic> json) {
  return MasterClassGetResponse(
    count: json['count'] as int,
    next: json['next'] as String,
    previous: json['previous'] as String,
    results: (json['results'] as List)
        ?.map((e) =>
            e == null ? null : MasterClass.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$MasterClassGetResponseToJson(
        MasterClassGetResponse instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results,
    };
