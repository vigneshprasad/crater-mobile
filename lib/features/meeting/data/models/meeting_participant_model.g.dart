// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meeting_participant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeetingParticipantModel _$MeetingParticipantModelFromJson(
    Map<String, dynamic> json) {
  return MeetingParticipantModel(
    pk: json['pk'] as String?,
    name: json['name'] as String?,
    introduction: json['introduction'] as String?,
    photo: json['photo'] as String?,
    rsvp: json['rsvp'] == null
        ? null
        : MeetingRsvpModel.fromJson(json['rsvp'] as Map<String, dynamic>),
    interests: (json['interests'] as List<dynamic>?)
        ?.map((e) => MeetingInterestModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    objectives: (json['objectives'] as List<dynamic>?)
        ?.map((e) => MeetingObjectiveModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$MeetingParticipantModelToJson(
        MeetingParticipantModel instance) =>
    <String, dynamic>{
      'pk': instance.pk,
      'name': instance.name,
      'introduction': instance.introduction,
      'photo': instance.photo,
      'rsvp': instance.rsvp,
      'interests': instance.interests,
      'objectives': instance.objectives,
    };
