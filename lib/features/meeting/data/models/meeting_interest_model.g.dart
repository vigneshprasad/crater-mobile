// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meeting_interest_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeetingInterestModel _$MeetingInterestModelFromJson(Map<String, dynamic> json) {
  return MeetingInterestModel(
    pk: json['pk'] as int,
    name: json['name'] as String,
    icon: json['icon'] as String?,
  );
}

Map<String, dynamic> _$MeetingInterestModelToJson(
        MeetingInterestModel instance) =>
    <String, dynamic>{
      'pk': instance.pk,
      'name': instance.name,
      'icon': instance.icon,
    };
