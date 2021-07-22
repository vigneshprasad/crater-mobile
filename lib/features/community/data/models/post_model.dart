import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../constants/app_hive_boxes.dart';
import '../../domain/entity/post_entity.dart';
import 'comment_model.dart';

part 'post_model.g.dart';

// ignore_for_file: annotate_overrides
// ignore_for_file: overridden_fields

@HiveType(typeId: AppHiveTypeIds.post)
@JsonSerializable()
class PostModel extends Post {
  @HiveField(0)
  final int pk;

  @HiveField(1)
  final String? message;

  @HiveField(2)
  final int? group;

  @HiveField(3)
  @JsonKey(name: "group_name")
  final String? groupName;

  @HiveField(4)
  @JsonKey(name: "files_urls")
  final List<String>? filesUrls;

  @HiveField(5)
  @JsonKey(name: "files_data")
  final List<FileDataModel>? filesData;

  @HiveField(6)
  final String? creator;

  @HiveField(7)
  @JsonKey(name: "creator_name")
  final String? creatorName;

  @HiveField(8)
  @JsonKey(name: "is_creator_approved")
  final bool? isCreatorApproved;

  @HiveField(9)
  @JsonKey(name: "creator_photo")
  final String? creatorPhoto;

  @HiveField(10)
  final String? created;

  @HiveField(11)
  final int? likes;

  @HiveField(12)
  @JsonKey(name: "my_like")
  final bool? myLike;

  @HiveField(13)
  @JsonKey(name: "is_followed")
  final bool? isFollowed;

  @HiveField(14)
  @JsonKey(name: "is_reported")
  final bool? isReported;

  @HiveField(15)
  final int? comments;

  @HiveField(16)
  @JsonKey(name: "latest_comments")
  final List<CommentModel>? latestComments;

  PostModel({
    required this.pk,
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
  }) : super(
          pk: pk,
          message: message,
          group: group,
          groupName: groupName,
          filesUrls: filesUrls,
          filesData: filesData,
          creator: creator,
          creatorName: creatorName,
          isCreatorApproved: isCreatorApproved,
          creatorPhoto: creatorPhoto,
          created: created,
          likes: likes,
          myLike: myLike,
          isFollowed: isFollowed,
          isReported: isReported,
          comments: comments,
          latestComments: latestComments,
        );

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);
  Map<String, dynamic> toJson() => _$PostModelToJson(this);
}

@HiveType(typeId: AppHiveTypeIds.fileData)
@JsonSerializable()
class FileDataModel extends FileData {
  @HiveField(0)
  final String file;

  @HiveField(1)
  @JsonKey(name: "is_video")
  final bool isVideo;

  @HiveField(2)
  final String thumbnail;

  const FileDataModel({
    required this.file,
    required this.isVideo,
    required this.thumbnail,
  }) : super(
          file: file,
          isVideo: isVideo,
          thumbnail: thumbnail,
        );

  factory FileDataModel.fromJson(Map<String, dynamic> json) =>
      _$FileDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$FileDataModelToJson(this);
}
