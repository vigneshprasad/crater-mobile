import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/meeting_rsvp_entity.dart';
import 'meeting_interest_model.dart';
import 'meeting_objective_model.dart';
import 'meeting_participant_model.dart';

part 'meeting_rsvp_model.g.dart';

// ignore_for_file: annotate_overrides
// ignore_for_file: overridden_fields

enum MeetingRsvpStatus {
  @JsonValue("attending")
  attending,

  @JsonValue("pending")
  pending,

  @JsonValue("not_attending")
  notAttending,

  @JsonValue("reschedule")
  reschedule,
}

@JsonSerializable()
class MeetingRsvpModel extends MeetingRsvp {
  final MeetingParticipantModel participant;
  final int pk;
  final MeetingRsvpStatus status;
  final List<MeetingInterestModel> interests;
  final List<MeetingObjectiveModel> objectives;

  MeetingRsvpModel({
    this.participant,
    this.pk,
    this.status,
    this.interests,
    this.objectives,
  }) : super(
          participant: participant,
          pk: pk,
          status: status,
          interests: interests,
          objectives: objectives,
        );

  factory MeetingRsvpModel.fromJson(Map<String, dynamic> json) =>
      _$MeetingRsvpModelFromJson(json);
  Map<String, dynamic> toJson() => _$MeetingRsvpModelToJson(this);
}
