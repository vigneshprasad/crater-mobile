import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../constants/app_hive_boxes.dart';
import '../../domain/entity/points_entity.dart';

part 'points_model.g.dart';

// ignore_for_file: annotate_overrides
// ignore_for_file: overridden_fields

@JsonSerializable()
@HiveType(typeId: AppHiveTypeIds.points)
class PointsModel extends Points {
  @HiveField(0)
  final int points;

  PointsModel({
    this.points,
  }) : super(points: points);

  factory PointsModel.fromJson(Map<String, dynamic> json) =>
      _$PointsModelFromJson(json);
  Map<String, dynamic> toJson() => _$PointsModelToJson(this);
}
