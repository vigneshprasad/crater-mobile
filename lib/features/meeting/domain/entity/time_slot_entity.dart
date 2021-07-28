import 'package:hive/hive.dart';

class TimeSlot extends HiveObject {
  final int? pk;
  final DateTime? end;
  final DateTime? start;

  TimeSlot({
    this.pk,
    this.end,
    this.start,
  });
}
