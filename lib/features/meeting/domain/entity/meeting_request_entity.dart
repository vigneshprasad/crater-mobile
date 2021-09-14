import 'package:hive/hive.dart';
import 'package:worknetwork/features/meeting/data/models/meeting_participant_model.dart';
import '../../data/models/meeting_request_model.dart';

class MeetingRequest extends HiveObject {
  final int? id;

  final DateTime? expiresAt;

  final MeetingRequestStatus? status;

  final List<DateTime>? timeSlots;

  final String? requestedBy;

  final String? requestedTo;

  final bool? isPast;

  final MeetingParticipantModel? participantDetail;

  MeetingRequest({
    this.id,
    this.expiresAt,
    this.status,
    this.timeSlots,
    this.requestedBy,
    this.requestedTo,
    this.isPast,
    this.participantDetail,
  });
}
