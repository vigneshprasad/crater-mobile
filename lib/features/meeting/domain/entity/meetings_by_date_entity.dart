import 'package:hive/hive.dart';

import 'meeting_entity.dart';

class MeetingsByDate extends HiveObject {
  final DateTime? date;
  final List<Meeting>? meetings;

  MeetingsByDate({
    this.date,
    this.meetings,
  });
}
