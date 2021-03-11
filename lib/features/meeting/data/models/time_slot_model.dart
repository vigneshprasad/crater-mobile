import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/time_slot_entity.dart';

part 'time_slot_model.g.dart';

// ignore_for_file: annotate_overrides
// ignore_for_file: overridden_fields

@JsonSerializable()
class TimeSlotModel extends TimeSlot {
  final int pk;
  final DateTime end;
  final DateTime start;

  TimeSlotModel({
    this.pk,
    this.end,
    this.start,
  }) : super(
          pk: pk,
          end: end,
          start: start,
        );

  factory TimeSlotModel.fromJson(Map<String, dynamic> json) =>
      _$TimeSlotModelFromJson(json);
  Map<String, dynamic> toJson() => _$TimeSlotModelToJson(this);
}
