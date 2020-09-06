import 'package:hive/hive.dart';

class Article extends HiveObject {
  final int pk;
  final String created;
  final String picture;
  final String tag;
  final String text;
  final String title;
  final String websiteTag;
  final String websiteUrl;

  Article({
    this.pk,
    this.created,
    this.picture,
    this.tag,
    this.text,
    this.title,
    this.websiteTag,
    this.websiteUrl,
  });
}
