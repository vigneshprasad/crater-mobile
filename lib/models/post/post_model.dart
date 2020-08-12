import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:worknetwork/models/comment/comment_model.dart';

part 'post_model.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class PostModel {
  @HiveField(0)
  final int pk;

  @HiveField(1)
  final String message;

  @HiveField(2)
  final int group;

  @HiveField(3)
  @JsonKey(name: "group_name")
  final String groupName;

  @HiveField(4)
  @JsonKey(name: "files_urls")
  final List<String> filesUrls;

  @HiveField(5)
  @JsonKey(name: "files_data", nullable: true)
  final List<FileData> filesData;

  @HiveField(6)
  final String creator;

  @HiveField(7)
  @JsonKey(name: "creator_name")
  final String creatorName;

  @HiveField(8)
  @JsonKey(name: "is_creator_approved")
  final bool isCreatorApproved;

  @HiveField(9)
  @JsonKey(name: "creator_photo")
  final String creatorPhoto;

  @HiveField(10)
  final String created;

  @HiveField(11)
  final int likes;

  @HiveField(12)
  @JsonKey(name: "my_like")
  final bool myLike;

  @HiveField(13)
  @JsonKey(name: "is_followed")
  final bool isFollowed;

  @HiveField(14)
  @JsonKey(name: "is_reported")
  final bool isReported;

  @HiveField(15)
  final int comments;

  @HiveField(16)
  @JsonKey(name: "latest_comments")
  final List<Comment> latestComments;

  PostModel({
    this.pk,
    this.message,
    this.group,
    this.groupName,
    this.filesUrls,
    this.filesData,
    this.creator,
    this.creatorName,
    this.isCreatorApproved,
    this.creatorPhoto,
    this.created,
    this.likes,
    this.myLike,
    this.isFollowed,
    this.isReported,
    this.comments,
    this.latestComments,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);
  Map<String, dynamic> toJson() => _$PostModelToJson(this);
}

@JsonSerializable()
class FileData {
  final String file;

  @JsonKey(name: 'is_video')
  final bool isVideo;

  final String thumbnail;

  FileData({
    this.file,
    this.isVideo,
    this.thumbnail,
  });

  factory FileData.fromJson(Map<String, dynamic> json) =>
      _$FileDataFromJson(json);
  Map<String, dynamic> toJson() => _$FileDataToJson(this);
}
