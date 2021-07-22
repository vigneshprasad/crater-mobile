import 'package:hive/hive.dart';

class RescheduleRequest extends HiveObject {
  final int id;
  final int? oldMeeting;
  final List<DateTime>? timeSlots;
  final String? requestedBy;

  RescheduleRequest({
    required this.id,
    this.oldMeeting,
    this.timeSlots,
    this.requestedBy,
  });
}
