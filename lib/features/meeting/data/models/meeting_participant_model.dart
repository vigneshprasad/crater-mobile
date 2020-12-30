import 'package:json_annotation/json_annotation.dart';
import 'package:worknetwork/features/meeting/data/models/meeting_interest_model.dart';
import 'package:worknetwork/features/meeting/data/models/meeting_objective_model.dart';
import 'package:worknetwork/features/meeting/data/models/meeting_rsvp_model.dart';

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
  final MeetingRsvpModel rsvp;
  final List<MeetingInterestModel> interests;
  final List<MeetingObjectiveModel> objectives;

  MeetingParticipantModel({
    this.pk,
    this.name,
    this.introduction,
    this.photo,
    this.rsvp,
    this.interests,
    this.objectives,
  }) : super(
          pk: pk,
          name: name,
          introduction: introduction,
          photo: photo,
          rsvp: rsvp,
          interests: interests,
          objectives: objectives,
        );

  factory MeetingParticipantModel.fromJson(Map<String, dynamic> json) =>
      _$MeetingParticipantModelFromJson(json);
  Map<String, dynamic> toJson() => _$MeetingParticipantModelToJson(this);
}
