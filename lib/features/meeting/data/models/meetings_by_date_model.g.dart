// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meetings_by_date_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeetingsByDateModel _$MeetingsByDateModelFromJson(Map<String, dynamic> json) {
  return MeetingsByDateModel(
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
    meetings: (json['meetings'] as List<dynamic>?)
        ?.map((e) => MeetingModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$MeetingsByDateModelToJson(
        MeetingsByDateModel instance) =>
    <String, dynamic>{
      'date': instance.date?.toIso8601String(),
      'meetings': instance.meetings,
    };
