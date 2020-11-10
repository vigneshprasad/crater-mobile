import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/meeting_entity.dart';
import 'meeting_participant_model.dart';

part 'meeting_model.g.dart';

// ignore_for_file: annotate_overrides
// ignore_for_file: overridden_fields

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

  @JsonKey(name: 'time_slot')
  final int timeSlot;

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
  });

  factory MeetingModel.fromJson(Map<String, dynamic> json) =>
      _$MeetingModelFromJson(json);
  Map<String, dynamic> toJson() => _$MeetingModelToJson(this);
}
