import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../constants/app_hive_boxes.dart';
import '../../domain/entity/user_tag_entity.dart';

part 'user_tag_model.g.dart';

// ignore_for_file: annotate_overrides
// ignore_for_file: overridden_fields

@HiveType(typeId: AppHiveTypeIds.userTag)
@JsonSerializable()
class UserTagModel extends UserTag {
  final String name;
  final int pk;

  UserTagModel({
    this.name,
    this.pk,
  }) : super(
          name: name,
          pk: pk,
        );

  factory UserTagModel.fromJson(Map<String, dynamic> json) =>
      _$UserTagModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserTagModelToJson(this);
}
