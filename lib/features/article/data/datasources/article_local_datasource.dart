import 'package:hive/hive.dart';
import 'package:worknetwork/constants/app_hive_boxes.dart';
import 'package:worknetwork/core/error/exceptions.dart';
import 'package:worknetwork/features/article/data/models/article_model.dart';

import '../../domain/entity/article_entity.dart';

abstract class ArticleLocalDatasource {
  Future<void> persistArticlesToCache(List<Article> articles);
  List<Article> getAllArticlesFromCache();
}

class ArticleLocalDatasourceImpl implements ArticleLocalDatasource {
  final Box<ArticleModel> _box =
      Hive.box<ArticleModel>(AppHiveBoxes.articlesBox);

  @override
  List<Article> getAllArticlesFromCache() {
    if (_box.isEmpty) {
      throw CacheException("${_box.name} is empty");
    }
    return _box.values.toList();
  }

  @override
  Future<void> persistArticlesToCache(List<Article> articles) async {
    final Map<String, ArticleModel> entries = articles.fold(
        {},
        (previousValue, element) => {
              ...previousValue,
              element.pk.toString(): element as ArticleModel,
            });
    try {
      await _box.putAll(entries);
    } catch (error) {
      throw CacheException(error);
    }
  }
}
