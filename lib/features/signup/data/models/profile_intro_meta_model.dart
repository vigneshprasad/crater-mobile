import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../constants/app_hive_boxes.dart';
import '../../domain/entity/profile_intro_meta.dart';

part 'profile_intro_meta_model.g.dart';

// ignore_for_file: annotate_overrides
// ignore_for_file: overridden_fields

@HiveType(typeId: AppHiveTypeIds.userTag)
@JsonSerializable()
class ProfileIntroMetaModel extends ProfileIntroMeta {
  final int value;
  final String name;

  ProfileIntroMetaModel({
    this.value,
    this.name,
  }) : super(
          value: value,
          name: name,
        );

  factory ProfileIntroMetaModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileIntroMetaModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileIntroMetaModelToJson(this);
}
