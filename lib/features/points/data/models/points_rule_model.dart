import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../constants/app_hive_boxes.dart';
import '../../domain/entity/points_rule_entity.dart';

part 'points_rule_model.g.dart';

// ignore_for_file: annotate_overrides
// ignore_for_file: overridden_fields

@JsonSerializable()
@HiveType(typeId: AppHiveTypeIds.pointsRule)
class PointsRuleModel extends PointsRule {
  @HiveField(0)
  @JsonKey(name: "key")
  final int? pointsKey;

  @HiveField(1)
  final String? desc;

  @HiveField(2)
  @JsonKey(name: "points_value")
  final int? pointsValue;

  PointsRuleModel({
    this.pointsKey,
    this.desc,
    this.pointsValue,
  }) : super(
          pointsKey: pointsKey,
          desc: desc,
          pointsValue: pointsValue,
        );

  factory PointsRuleModel.fromJson(Map<String, dynamic> json) =>
      _$PointsRuleModelFromJson(json);
  Map<String, dynamic> toJson() => _$PointsRuleModelToJson(this);
}
