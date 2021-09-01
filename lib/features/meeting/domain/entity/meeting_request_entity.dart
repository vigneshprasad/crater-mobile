import 'package:hive/hive.dart';
import 'package:worknetwork/features/meeting/data/models/meeting_request_model.dart';

import '../../data/models/meeting_model.dart';
import 'meeting_participant_entity.dart';

class MeetingRequest extends HiveObject {
  final int? id;

  final DateTime? expiresAt;

  final MeetingRequestStatus? status;

  final List<DateTime>? timeSlots;

  final String? requestedBy;

  final String? requestedTo;

  MeetingRequest({
    this.id,
    this.expiresAt,
    this.status,
    this.timeSlots,
    this.requestedBy,
    this.requestedTo,
  });
}
