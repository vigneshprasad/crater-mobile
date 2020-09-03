import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../constants/app_hive_boxes.dart';
import '../../domain/entity/comment_entity.dart';

part 'comment_model.g.dart';

// ignore_for_file: annotate_overrides
// ignore_for_file: overridden_fields

@HiveType(typeId: AppHiveTypeIds.comment)
@JsonSerializable()
class CommentModel extends Comment {
  @HiveField(0)
  final int pk;

  @HiveField(1)
  final String message;

  @HiveField(2)
  @JsonKey(name: 'creator_id')
  final String creatorId;

  @HiveField(3)
  @JsonKey(name: 'creator_name')
  final String creatorName;

  @HiveField(4)
  @JsonKey(name: 'creator_photo')
  final String creatorPhoto;

  @HiveField(5)
  final String created;

  CommentModel({
    this.pk,
    this.message,
    this.creatorId,
    this.creatorName,
    this.creatorPhoto,
    this.created,
  }) : super(
          pk: pk,
          message: message,
          creatorId: creatorId,
          creatorName: creatorName,
          creatorPhoto: creatorPhoto,
          created: created,
        );

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);
  Map<String, dynamic> toJson() => _$CommentModelToJson(this);
}
