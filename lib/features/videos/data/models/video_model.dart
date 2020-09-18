import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../constants/app_hive_boxes.dart';
import '../../domain/entity/video_entity.dart';
import 'video_tag_model.dart';

part 'video_model.g.dart';

// ignore_for_file: annotate_overrides
// ignore_for_file: overridden_fields

@HiveType(typeId: AppHiveTypeIds.video)
@JsonSerializable()
class VideoModel extends Video {
  @HiveField(0)
  final int pk;

  @HiveField(1)
  final String author;

  @HiveField(2)
  final String cover;

  @HiveField(3)
  final String created;

  @HiveField(4)
  final String description;

  @HiveField(5)
  final String position;

  @HiveField(6)
  final String thumbnail;

  @HiveField(7)
  final List<VideoTagModel> tags;

  VideoModel({
    this.pk,
    this.author,
    this.cover,
    this.created,
    this.description,
    this.position,
    this.thumbnail,
    this.tags,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) =>
      _$VideoModelFromJson(json);
  Map<String, dynamic> toJson() => _$VideoModelToJson(this);
}
