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
  final String? message;

  @HiveField(2)
  @JsonKey(name: 'creator_id')
  final String? creatorId;

  @HiveField(3)
  @JsonKey(name: 'creator_name')
  final String? creatorName;

  @HiveField(4)
  @JsonKey(name: 'creator_photo')
  final String? creatorPhoto;

  @HiveField(5)
  final DateTime? created;

  @HiveField(6)
  final int? postId;

  CommentModel({
    required this.pk,
    this.message,
    this.creatorId,
    this.creatorName,
    this.creatorPhoto,
    this.created,
    this.postId,
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

  CommentModel copyWith({
    int? pk,
    String? message,
    String? creatorId,
    String? creatorName,
    String? creatorPhoto,
    DateTime? created,
    int? postId,
  }) {
    return CommentModel(
      pk: pk ?? this.pk,
      message: message ?? this.message,
      creatorId: creatorId ?? this.creatorId,
      creatorName: creatorName ?? this.creatorName,
      creatorPhoto: creatorPhoto ?? this.creatorPhoto,
      created: created ?? this.created,
      postId: postId ?? this.postId,
    );
  }
}
