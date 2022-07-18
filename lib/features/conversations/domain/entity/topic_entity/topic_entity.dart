import 'package:freezed_annotation/freezed_annotation.dart';

part 'topic_entity.freezed.dart';
part 'topic_entity.g.dart';

enum TopicType { group, ama }

@freezed
abstract class Topic with _$Topic {
  factory Topic({
    int? id,
    String? name,
    String? image,
    @JsonKey(name: "is_active") bool? active,
    int? parent,
    String? description,
    int? article,
    @JsonKey(name: "is_approved") bool? approved,
    String? creator,
    Topic? root,
    int? groupCount,
    TopicType? type,
    @JsonKey(name: "article_detail") Article? articleDetail,
  }) = _Topic;

  factory Topic.fromCountJson(Map<String, dynamic> json) {
    final topic = Topic.fromJson(json['topic'] as Map<String, dynamic>)
        .copyWith(groupCount: json['group_count'] as int);
    return topic;
  }

  factory Topic.fromJson(Map<String, dynamic> json) => _$TopicFromJson(json);
}

@freezed
abstract class Article with _$Article {
  factory Article({
    int? pk,
    String? title,
    String? description,
    String? image,
    String? tag,
    @JsonKey(name: "website_tag") String? websiteTag,
    @JsonKey(name: "website_url") String? websiteUrl,
    // @JsonKey(name: "website_tag_detail")
    //     ArticleWebsiteSource? articleSourceDetail,
  }) = _Article;

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);
}
