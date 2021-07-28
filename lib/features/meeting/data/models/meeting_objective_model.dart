import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/meeting_objective_entity.dart';

part 'meeting_objective_model.g.dart';

// ignore_for_file: annotate_overrides
// ignore_for_file: overridden_fields

@JsonSerializable()
class MeetingObjectiveModel extends MeetingObjective {
  final String? icon;
  final String? name;
  final int? pk;
  final ObjectiveType? type;

  const MeetingObjectiveModel({
    this.icon,
    this.name,
    this.pk,
    this.type,
  }) : super(
          icon: icon,
          name: name,
          pk: pk,
          type: type,
        );

  factory MeetingObjectiveModel.fromJson(Map<String, dynamic> json) =>
      _$MeetingObjectiveModelFromJson(json);
  Map<String, dynamic> toJson() => _$MeetingObjectiveModelToJson(this);
}
