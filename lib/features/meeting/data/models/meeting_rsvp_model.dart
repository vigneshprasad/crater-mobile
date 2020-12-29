import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/meeting_rsvp_entity.dart';
import 'meeting_interest_model.dart';
import 'meeting_objective_model.dart';

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
  final int pk;
  final MeetingRsvpStatus status;

  MeetingRsvpModel({
    this.pk,
    this.status,
  }) : super(
          pk: pk,
          status: status,
        );

  factory MeetingRsvpModel.fromJson(Map<String, dynamic> json) =>
      _$MeetingRsvpModelFromJson(json);
  Map<String, dynamic> toJson() => _$MeetingRsvpModelToJson(this);
}
