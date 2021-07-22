import 'package:hive/hive.dart';

class TimeSlot extends HiveObject {
  final int pk;
  final DateTime? end;
  final DateTime? start;

  TimeSlot({
    required this.pk,
    this.end,
    this.start,
  });
}
