import 'package:freezed_annotation/freezed_annotation.dart';

import '../article_website_source/article_website_source.dart';

part 'article_entity.freezed.dart';
part 'article_entity.g.dart';

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
    @JsonKey(name: "website_tag_detail")
        ArticleWebsiteSource? articleSourceDetail,
  }) = _Article;

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);
}
