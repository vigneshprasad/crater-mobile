import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/meetings_by_date_entity.dart';
import 'meeting_model.dart';

part 'meetings_by_date_model.g.dart';

// ignore_for_file: annotate_overrides
// ignore_for_file: overridden_fields

@JsonSerializable()
class MeetingsByDateModel extends MeetingsByDate {
  final DateTime date;
  final List<MeetingModel> meetings;

  MeetingsByDateModel({
    this.date,
    this.meetings,
  }) : super(
          date: date,
          meetings: meetings,
        );

  factory MeetingsByDateModel.fromJson(Map<String, dynamic> json) =>
      _$MeetingsByDateModelFromJson(json);
  Map<String, dynamic> toJson() => _$MeetingsByDateModelToJson(this);
}
