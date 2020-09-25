import 'package:hive/hive.dart';

import '../../../../constants/app_hive_boxes.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entity/article_entity.dart';
import '../../domain/entity/article_website_entity.dart';
import '../models/article_model.dart';
import '../models/article_website_model.dart';

abstract class ArticleLocalDatasource {
  Future<void> persistArticlesToCache(List<Article> articles);
  List<Article> getAllArticlesFromCache();
  Future<void> persistArticleWebsitesToCache(List<ArticleWebsite> websites);
  List<ArticleWebsite> getArticleWebsitesFromCache();
}

class ArticleLocalDatasourceImpl implements ArticleLocalDatasource {
  final Box<ArticleModel> _articlesBox =
      Hive.box<ArticleModel>(AppHiveBoxes.articlesBox);
  final Box<ArticleWebsiteModel> _articleWebsiteBox =
      Hive.box<ArticleWebsiteModel>(AppHiveBoxes.articlesWebsiteBox);

  @override
  List<Article> getAllArticlesFromCache() {
    if (_articlesBox.isEmpty) {
      throw CacheException("${_articlesBox.name} is empty");
    }
    return _articlesBox.values.toList();
  }

  @override
  Future<void> persistArticlesToCache(List<Article> articles) async {
    final Map<String, ArticleModel> entries = articles.fold(
      {},
      (previousValue, element) => {
        ...previousValue,
        element.pk.toString(): element as ArticleModel,
      },
    );
    try {
      await _articlesBox.putAll(entries);
    } catch (error) {
      throw CacheException(error);
    }
  }

  @override
  List<ArticleWebsite> getArticleWebsitesFromCache() {
    if (_articleWebsiteBox.isEmpty) {
      throw CacheException("${_articleWebsiteBox.name} is empty");
    }
    return _articleWebsiteBox.values.toList();
  }

  @override
  Future<void> persistArticleWebsitesToCache(
      List<ArticleWebsite> websites) async {
    final Map<String, ArticleWebsiteModel> entries = websites.fold(
      {},
      (previousValue, element) => {
        ...previousValue,
        element.pk.toString(): element as ArticleWebsiteModel,
      },
    );
    try {
      await _articleWebsiteBox.putAll(entries);
    } catch (error) {
      throw CacheException(error);
    }
  }
}
