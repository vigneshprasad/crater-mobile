import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:worknetwork/constants/app_hive_boxes.dart';

import '../../domain/entity/points_faq_entity.dart';

part 'points_faq_model.g.dart';

// ignore_for_file: annotate_overrides
// ignore_for_file: overridden_fields

@JsonSerializable()
@HiveType(typeId: AppHiveTypeIds.pointsFaq)
class PointsFaqModel extends PointsFaq {
  @HiveField(0)
  final int pk;

  @HiveField(1)
  final String category;

  @HiveField(2)
  final String question;

  @HiveField(3)
  final String answer;

  @HiveField(4)
  final int order;

  PointsFaqModel({
    this.pk,
    this.category,
    this.question,
    this.answer,
    this.order,
  }) : super(
          pk: pk,
          category: category,
          question: question,
          answer: answer,
          order: order,
        );

  factory PointsFaqModel.fromJson(Map<String, dynamic> json) =>
      _$PointsFaqModelFromJson(json);
  Map<String, dynamic> toJson() => _$PointsFaqModelToJson(this);
}
