import 'package:hive/hive.dart';

import 'meeting_interest_entity.dart';
import 'meeting_objective_entity.dart';
import 'meeting_rsvp_entity.dart';

class MeetingParticipant extends HiveObject {
  final String? pk;
  final String? name;
  final String? introduction;
  final String? photo;
  final MeetingRsvp? rsvp;
  final List<MeetingInterest>? interests;
  final List<MeetingObjective>? objectives;

  MeetingParticipant({
    this.pk,
    this.name,
    this.introduction,
    this.photo,
    this.rsvp,
    this.interests,
    this.objectives,
  });
}
