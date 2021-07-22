import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/meeting_config_entity.dart';
import 'time_slot_model.dart';

part 'meeting_config_model.g.dart';

// ignore_for_file: annotate_overrides
// ignore_for_file: overridden_fields

@JsonSerializable()
class MeetingConfigModel extends MeetingConfig {
  final int pk;

  final String? title;

  @JsonKey(name: 'week_start_date')
  final String weekStartDate;

  @JsonKey(name: 'week_end_date')
  final String? weekEndDate;

  @JsonKey(name: 'is_registration_open')
  final bool? isRegistrationOpen;

  @JsonKey(name: 'is_active')
  final bool? isActive;

  @JsonKey(name: 'available_time_slots')
  final Map<String, List<TimeSlotModel>> availableTimeSlots;

  MeetingConfigModel({
    required this.pk,
    this.title,
    required this.weekStartDate,
    this.weekEndDate,
    this.isRegistrationOpen,
    this.isActive,
    required this.availableTimeSlots,
  }) : super(
          availableTimeSlots: availableTimeSlots,
          pk: pk,
          title: title,
          weekStartDate: weekStartDate,
          weekEndDate: weekEndDate,
          isActive: isActive,
          isRegistrationOpen: isRegistrationOpen,
        );

  factory MeetingConfigModel.fromJson(Map<String, dynamic> json) =>
      _$MeetingConfigModelFromJson(json);
  Map<String, dynamic> toJson() => _$MeetingConfigModelToJson(this);
}
