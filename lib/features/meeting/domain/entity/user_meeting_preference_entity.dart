import 'package:hive/hive.dart';

class UserMeetingPreference extends HiveObject {
  final int pk;
  final int meeting;
  final int numberOfMeetings;
  final String objective;
  final List<int> interests;
  final List<int> timeSlots;

  UserMeetingPreference({
    this.pk,
    this.meeting,
    this.numberOfMeetings,
    this.objective,
    this.interests,
    this.timeSlots,
  });
}
