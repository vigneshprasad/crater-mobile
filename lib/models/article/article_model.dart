import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'article_model.g.dart';

@HiveType(typeId: 4)
@JsonSerializable()
class Article {
  @HiveField(0)
  final int pk;

  @HiveField(1)
  final String created;
  @HiveField(2)
  final String picture;

  @HiveField(3)
  final String tag;

  @HiveField(4)
  final String text;

  @HiveField(5)
  final String title;

  @HiveField(6)
  @JsonKey(name: 'website_tag')
  final String websiteTag;

  @HiveField(7)
  @JsonKey(name: 'website_url')
  final String websiteUrl;

  Article(
    this.pk,
    this.created,
    this.picture,
    this.tag,
    this.text,
    this.title,
    this.websiteTag,
    this.websiteUrl,
  );

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}
