import 'package:json_annotation/json_annotation.dart';

import 'package:worknetwork/features/meeting/domain/entity/reschedule_request_entity.dart';

part 'reschedule_request_model.g.dart';

// ignore_for_file: annotate_overrides
// ignore_for_file: overridden_fields

@JsonSerializable()
class RescheduleRequestModel extends RescheduleRequest {
  final int id;

  @JsonKey(name: 'old_meeting')
  final int oldMeeting;

  @JsonKey(name: 'time_slots')
  final List<DateTime> timeSlots;

  @JsonKey(name: 'requested_by')
  final String requestedBy;

  RescheduleRequestModel({
    this.id,
    this.oldMeeting,
    this.timeSlots,
    this.requestedBy,
  }) : super(
          id: id,
          oldMeeting: oldMeeting,
          timeSlots: timeSlots,
          requestedBy: requestedBy,
        );

  factory RescheduleRequestModel.fromJson(Map<String, dynamic> json) =>
      _$RescheduleRequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$RescheduleRequestModelToJson(this);
}
