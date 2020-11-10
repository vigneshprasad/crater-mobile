// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meeting_participant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeetingParticipantModel _$MeetingParticipantModelFromJson(
    Map<String, dynamic> json) {
  return MeetingParticipantModel(
    pk: json['pk'] as String,
    name: json['name'] as String,
    introduction: json['introduction'] as String,
    photo: json['photo'] as String,
  );
}

Map<String, dynamic> _$MeetingParticipantModelToJson(
        MeetingParticipantModel instance) =>
    <String, dynamic>{
      'pk': instance.pk,
      'name': instance.name,
      'introduction': instance.introduction,
      'photo': instance.photo,
    };
