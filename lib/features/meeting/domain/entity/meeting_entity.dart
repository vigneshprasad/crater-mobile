import 'package:hive/hive.dart';

import '../../data/models/meeting_model.dart';
import 'meeting_participant_entity.dart';

class Meeting extends HiveObject {
  final int? config;
  final DateTime end;
  final bool? isCanceled;
  final bool isPast;
  final String? link;
  final List<MeetingParticipant>? participants;
  final int pk;
  final DateTime start;
  final int? timeSlot;
  final MeetingStatus status;
  final MeetingParticipant? participantDetail;

  Meeting({
    this.config,
    required this.end,
    this.isCanceled,
    required this.isPast,
    this.link,
    this.participants,
    required this.pk,
    required this.start,
    this.timeSlot,
    required this.status,
    this.participantDetail,
  });
}
