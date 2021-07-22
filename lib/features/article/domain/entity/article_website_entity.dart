import 'package:hive/hive.dart';

class ArticleWebsite extends HiveObject {
  final int pk;
  final String name;
  final String url;

  ArticleWebsite({
    required this.pk,
    required this.name,
    required this.url,
  });
}
