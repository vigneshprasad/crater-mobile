import 'package:hive/hive.dart';

import '../../data/models/meeting_rsvp_model.dart';
import 'meeting_interest_entity.dart';
import 'meeting_objective_entity.dart';
import 'meeting_participant_entity.dart';

class MeetingRsvp extends HiveObject {
  final MeetingParticipant participant;
  final int pk;
  final MeetingRsvpStatus status;
  final List<MeetingInterest> interests;
  final List<MeetingObjective> objectives;

  MeetingRsvp({
    this.participant,
    this.pk,
    this.status,
    this.interests,
    this.objectives,
  });
}
