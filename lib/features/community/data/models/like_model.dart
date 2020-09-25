import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/like_entity.dart';

part 'like_model.g.dart';

// ignore_for_file: annotate_overrides
// ignore_for_file: overridden_fields

@JsonSerializable()
class LikeModel extends Like {
  @JsonKey(name: "like_count")
  final int likeCount;
  final int pk;
  final int post;
  final String user;

  LikeModel({
    this.likeCount,
    this.pk,
    this.post,
    this.user,
  }) : super(
          likeCount: likeCount,
          pk: pk,
          post: post,
          user: user,
        );

  factory LikeModel.fromJson(Map<String, dynamic> json) =>
      _$LikeModelFromJson(json);
  Map<String, dynamic> toJson() => _$LikeModelToJson(this);
}
