import 'package:hive/hive.dart';

class ArticleWebsite extends HiveObject {
  final int pk;
  final String name;
  final String url;

  ArticleWebsite({
    this.pk,
    this.name,
    this.url,
  });
}
