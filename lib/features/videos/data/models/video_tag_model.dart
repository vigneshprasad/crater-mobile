import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:worknetwork/constants/app_hive_boxes.dart';

import 'package:worknetwork/features/videos/domain/entity/video_tag_entity.dart';

part 'video_tag_model.g.dart';

// ignore_for_file: annotate_overrides
// ignore_for_file: overridden_fields

@HiveType(typeId: AppHiveTypeIds.videoTag)
@JsonSerializable()
class VideoTagModel extends VideoTag {
  @HiveField(0)
  final int pk;

  @HiveField(1)
  final String name;

  VideoTagModel({
    this.pk,
    this.name,
  });

  factory VideoTagModel.fromJson(Map<String, dynamic> json) =>
      _$VideoTagModelFromJson(json);
  Map<String, dynamic> toJson() => _$VideoTagModelToJson(this);
}
