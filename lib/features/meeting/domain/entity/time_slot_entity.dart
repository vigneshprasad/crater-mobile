import 'package:hive/hive.dart';

class TimeSlot extends HiveObject {
  final int pk;
  final String end;
  final String start;

  TimeSlot({
    this.pk,
    this.end,
    this.start,
  });
}
