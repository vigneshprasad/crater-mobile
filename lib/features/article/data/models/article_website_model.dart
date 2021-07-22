import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../constants/app_hive_boxes.dart';
import '../../domain/entity/article_website_entity.dart';

part 'article_website_model.g.dart';

// ignore_for_file: annotate_overrides
// ignore_for_file: overridden_fields

@HiveType(typeId: AppHiveTypeIds.articleWebsite)
@JsonSerializable()
class ArticleWebsiteModel extends ArticleWebsite {
  @HiveField(0)
  final int pk;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String url;

  ArticleWebsiteModel({
    required this.pk,
    required this.name,
    required this.url,
  }) : super(
          pk: pk,
          name: name,
          url: url,
        );

  factory ArticleWebsiteModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleWebsiteModelFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleWebsiteModelToJson(this);
}
