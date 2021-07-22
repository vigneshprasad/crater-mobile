import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/user_objective_entity.dart';

part 'user_objective_model.g.dart';

// ignore_for_file: annotate_overrides
// ignore_for_file: overridden_fields

@JsonSerializable()
class UserObjectiveModel extends UserObjective {
  final int pk;
  final String? icon;
  final String? name;

  UserObjectiveModel({
    required this.pk,
    this.icon,
    this.name,
  }) : super(
          pk: pk,
          icon: icon,
          name: name,
        );

  factory UserObjectiveModel.fromJson(Map<String, dynamic> json) =>
      _$UserObjectiveModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserObjectiveModelToJson(this);
}
