// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requests_by_date_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestsByDateModel _$RequestsByDateModelFromJson(Map<String, dynamic> json) {
  return RequestsByDateModel(
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
    meetingsRequests: (json['meeting_requests'] as List<dynamic>?)
        ?.map((e) => MeetingRequestModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$RequestsByDateModelToJson(
        RequestsByDateModel instance) =>
    <String, dynamic>{
      'date': instance.date?.toIso8601String(),
      'meeting_requests': instance.meetingsRequests,
    };
