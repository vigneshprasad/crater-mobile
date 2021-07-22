import 'package:hive/hive.dart';

import 'time_slot_entity.dart';

class MeetingConfig extends HiveObject {
  final int pk;
  final String? title;
  final String weekStartDate;
  final String? weekEndDate;
  final bool? isRegistrationOpen;
  final bool? isActive;
  final Map<String, List<TimeSlot>> availableTimeSlots;

  MeetingConfig({
    required this.pk,
    this.title,
    required this.weekStartDate,
    this.weekEndDate,
    this.isRegistrationOpen,
    this.isActive,
    required this.availableTimeSlots,
  });
}
