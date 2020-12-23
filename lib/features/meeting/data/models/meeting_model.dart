import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/meeting_entity.dart';
import 'meeting_participant_model.dart';
import 'meeting_rsvp_model.dart';

part 'meeting_model.g.dart';

// ignore_for_file: annotate_overrides
// ignore_for_file: overridden_fields

enum MeetingStatus {
  @JsonValue('confirmed')
  confirmed,

  @JsonValue('cancelled')
  cancelled,

  @JsonValue('pending')
  pending,

  @JsonValue('rescheduled')
  rescheduled,
}

@JsonSerializable()
class MeetingModel extends Meeting {
  final int config;
  final DateTime end;

  @JsonKey(name: 'is_canceled')
  final bool isCanceled;

  @JsonKey(name: 'is_past')
  final bool isPast;

  final String link;
  final List<MeetingParticipantModel> participants;
  final int pk;
  final DateTime start;
  final MeetingStatus status;

  @JsonKey(name: 'time_slot')
  final int timeSlot;

  final List<MeetingRsvpModel> rsvps;

  MeetingModel({
    this.config,
    this.end,
    this.isCanceled,
    this.isPast,
    this.link,
    this.participants,
    this.pk,
    this.start,
    this.timeSlot,
    this.rsvps,
    this.status,
  }) : super(
          config: config,
          end: end,
          isCanceled: isCanceled,
          isPast: isPast,
          link: link,
          participants: participants,
          pk: pk,
          start: start,
          timeSlot: timeSlot,
          rsvps: rsvps,
          status: status,
        );

  factory MeetingModel.fromJson(Map<String, dynamic> json) =>
      _$MeetingModelFromJson(json);
  Map<String, dynamic> toJson() => _$MeetingModelToJson(this);
}
