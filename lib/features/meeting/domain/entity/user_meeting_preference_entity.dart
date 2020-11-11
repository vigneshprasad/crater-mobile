import 'package:hive/hive.dart';

class UserMeetingPreference extends HiveObject {
  final int pk;
  final int meeting;
  final int numberOfMeetings;
  final List<int> objectives;
  final List<int> interests;
  final List<int> timeSlots;
  final String user;

  UserMeetingPreference({
    this.pk,
    this.meeting,
    this.numberOfMeetings,
    this.objectives,
    this.interests,
    this.timeSlots,
    this.user,
  });
}
