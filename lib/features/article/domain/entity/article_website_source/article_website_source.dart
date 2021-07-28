import 'package:freezed_annotation/freezed_annotation.dart';

part 'article_website_source.freezed.dart';
part 'article_website_source.g.dart';

@freezed
abstract class ArticleWebsiteSource with _$ArticleWebsiteSource {
  factory ArticleWebsiteSource({
    int? pk,
    String? name,
    String? url,
    String? image,
  }) = _ArticleWebsiteSource;

  factory ArticleWebsiteSource.fromJson(Map<String, dynamic> json) =>
      _$ArticleWebsiteSourceFromJson(json);
}
