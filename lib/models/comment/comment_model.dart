import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comment_model.g.dart';

@HiveType(typeId: 3)
@JsonSerializable()
class Comment {
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

  Comment({
    this.pk,
    this.message,
    this.creatorId,
    this.creatorName,
    this.creatorPhoto,
    this.created,
  });

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
