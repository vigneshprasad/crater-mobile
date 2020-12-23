import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/meeting_participant_entity.dart';

part 'meeting_participant_model.g.dart';

// ignore_for_file: annotate_overrides
// ignore_for_file: overridden_fields

@JsonSerializable()
class MeetingParticipantModel extends MeetingParticipant {
  final String pk;
  final String name;
  final String introduction;
  final String photo;

  MeetingParticipantModel({
    this.pk,
    this.name,
    this.introduction,
    this.photo,
  }) : super(
          pk: pk,
          name: name,
          introduction: introduction,
          photo: photo,
        );

  factory MeetingParticipantModel.fromJson(Map<String, dynamic> json) =>
      _$MeetingParticipantModelFromJson(json);
  Map<String, dynamic> toJson() => _$MeetingParticipantModelToJson(this);
}
