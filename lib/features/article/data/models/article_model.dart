import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../constants/app_hive_boxes.dart';
import '../../domain/entity/article_entity.dart';

part 'article_model.g.dart';

// ignore_for_file: annotate_overrides
// ignore_for_file: overridden_fields

@HiveType(typeId: AppHiveTypeIds.article)
@JsonSerializable()
class ArticleModel extends Article {
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

  ArticleModel({
    this.pk,
    this.created,
    this.picture,
    this.tag,
    this.text,
    this.title,
    this.websiteTag,
    this.websiteUrl,
  }) : super(
          pk: pk,
          created: created,
          picture: picture,
          tag: tag,
          text: text,
          title: title,
          websiteTag: websiteTag,
          websiteUrl: websiteUrl,
        );

  factory ArticleModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleModelFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleModelToJson(this);
}
