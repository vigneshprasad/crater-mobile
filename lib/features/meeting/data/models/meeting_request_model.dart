import 'package:json_annotation/json_annotation.dart';
import 'package:worknetwork/features/meeting/domain/entity/meeting_request_entity.dart';

import '../../domain/entity/meeting_entity.dart';
import 'meeting_participant_model.dart';

part 'meeting_request_model.g.dart';

// ignore_for_file: annotate_overrides
// ignore_for_file: overridden_fields

enum MeetingRequestStatus {
  @JsonValue('confirmed')
  confirmed,

  @JsonValue('pending_approval')
  pendingApproval,

  @JsonValue('declined')
  declined,
}

@JsonSerializable()
class MeetingRequestModel extends MeetingRequest {
  final int? id;

  @JsonKey(name: 'expires_at')
  final DateTime? expiresAt;

  final MeetingRequestStatus? status;

  @JsonKey(name: 'time_slots')
  final List<DateTime>? timeSlots;

  @JsonKey(name: 'requested_by')
  final String? requestedBy;

  @JsonKey(name: 'requested_to')
  final String? requestedTo;

  MeetingRequestModel({
    this.id,
    this.expiresAt,
    this.status,
    this.timeSlots,
    this.requestedBy,
    this.requestedTo,
  }) : super(
          id: id,
          expiresAt: expiresAt,
          status: status,
          timeSlots: timeSlots,
          requestedBy: requestedBy,
          requestedTo: requestedTo,
        );

  factory MeetingRequestModel.fromJson(Map<String, dynamic> json) =>
      _$MeetingRequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$MeetingRequestModelToJson(this);
}
