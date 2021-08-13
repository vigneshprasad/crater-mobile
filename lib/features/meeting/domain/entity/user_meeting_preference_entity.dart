import 'package:hive/hive.dart';

import 'meeting_interest_entity.dart';
import 'meeting_objective_entity.dart';

class UserMeetingPreference extends HiveObject {
  final int? pk;
  final int? meeting;
  final int? numberOfMeetings;
  final int? numberOfMeetingsPerMonth;
  final List<MeetingObjective>? objectives;
  final List<MeetingInterest>? interests;
  final List<int>? timeSlots;
  final String? user;

  UserMeetingPreference({
    this.pk,
    this.meeting,
    this.numberOfMeetings,
    this.numberOfMeetingsPerMonth,
    this.objectives,
    this.interests,
    this.timeSlots,
    this.user,
  });
}
