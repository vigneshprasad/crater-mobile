import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'comment_model.dart';
import 'post_model.dart';

part 'api_models.g.dart';

@JsonSerializable()
class PostsPageApiResponse extends Equatable {
  final int count;

  @JsonKey(name: "current_page")
  final int currentPage;

  final String next;

  final String previous;

  final List<PostModel> results;

  const PostsPageApiResponse({
    this.count,
    this.currentPage,
    this.next,
    this.previous,
    this.results,
  });

  @override
  List<Object> get props => [
        count,
        currentPage,
        next,
        previous,
        results,
      ];

  factory PostsPageApiResponse.fromJson(Map<String, dynamic> json) =>
      _$PostsPageApiResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PostsPageApiResponseToJson(this);
}

@JsonSerializable()
class CommentsPageApiResponse extends Equatable {
  final int count;

  @JsonKey(name: "current_page")
  final int currentPage;

  final String next;
  final String previous;
  final List<CommentModel> results;

  const CommentsPageApiResponse({
    this.count,
    this.currentPage,
    this.next,
    this.previous,
    this.results,
  });

  @override
  List<Object> get props => [
        count,
        currentPage,
        next,
        previous,
        results,
      ];

  factory CommentsPageApiResponse.fromJson(Map<String, dynamic> json) =>
      _$CommentsPageApiResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CommentsPageApiResponseToJson(this);
}
