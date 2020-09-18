import 'package:json_annotation/json_annotation.dart';
import 'package:worknetwork/features/meeting/domain/entity/meeting_objective_entity.dart';

part 'meeting_objective_model.g.dart';

// ignore_for_file: annotate_overrides
// ignore_for_file: overridden_fields

@JsonSerializable()
class MeetingObjectiveModel extends MeetingObjective {
  final String key;
  final String label;

  MeetingObjectiveModel({
    this.key,
    this.label,
  });

  factory MeetingObjectiveModel.fromJson(Map<String, dynamic> json) =>
      _$MeetingObjectiveModelFromJson(json);
  Map<String, dynamic> toJson() => _$MeetingObjectiveModelToJson(this);
}
