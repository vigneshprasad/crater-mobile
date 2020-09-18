import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import 'comment_entity.dart';

class Post extends HiveObject {
  final int pk;
  final String message;
  final int group;
  final String groupName;
  final List<String> filesUrls;
  final List<FileData> filesData;
  final String creator;
  final String creatorName;
  final bool isCreatorApproved;
  final String creatorPhoto;
  final String created;
  final int likes;
  final bool myLike;
  final bool isFollowed;
  final bool isReported;
  final int comments;
  final List<Comment> latestComments;

  Post({
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

  Post copyWith({
    int pk,
    String message,
    int group,
    String groupName,
    List<String> filesUrls,
    List<FileData> filesData,
    String creator,
    String creatorName,
    bool isCreatorApproved,
    String creatorPhoto,
    String created,
    int likes,
    bool myLike,
    bool isFollowed,
    bool isReported,
    int comments,
    List<Comment> latestComments,
  }) {
    return Post(
      pk: pk ?? this.pk,
      message: message ?? this.message,
      group: group ?? this.group,
      groupName: groupName ?? this.groupName,
      filesUrls: filesUrls ?? this.filesUrls,
      filesData: filesData ?? this.filesData,
      creator: creator ?? this.creator,
      creatorName: creatorName ?? this.creatorName,
      isCreatorApproved: isCreatorApproved ?? this.isCreatorApproved,
      creatorPhoto: creatorPhoto ?? this.creatorPhoto,
      created: created ?? this.created,
      likes: likes ?? this.likes,
      myLike: myLike ?? this.myLike,
      isFollowed: isFollowed ?? this.isFollowed,
      isReported: isReported ?? this.isReported,
      comments: comments ?? this.comments,
      latestComments: latestComments ?? this.latestComments,
    );
  }
}

class FileData extends Equatable {
  final String file;

  final bool isVideo;

  final String thumbnail;

  const FileData({
    this.file,
    this.isVideo,
    this.thumbnail,
  });

  @override
  // TODO: implement props
  List<Object> get props => [
        file,
        isVideo,
        thumbnail,
      ];
}
