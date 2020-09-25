import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../../api/articles/articles_api_service.dart';
import '../../../../api/tags/tags_api_service.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/page_api_response/page_api_response.dart';
import '../../domain/entity/article_entity.dart';
import '../../domain/entity/article_website_entity.dart';
import '../models/api_models.dart';
import '../models/article_website_model.dart';

abstract class ArticleRemoteDatasource {
  Future<PageApiResponse<Article>> getArticePageFromRemote(
      int page, int pageSize, int websiteTag);
  Future<List<ArticleWebsite>> getArticleWebsitesFromRemote();
}

class ArticleRemoteDatasourceImpl implements ArticleRemoteDatasource {
  final ArticlesApiService apiService;
  final TagsApiService tagsApiService;

  ArticleRemoteDatasourceImpl({
    @required this.apiService,
    @required this.tagsApiService,
  });

  @override
  Future<PageApiResponse<Article>> getArticePageFromRemote(
      int page, int pageSize, int websiteTag) async {
    final response =
        await apiService.getArticlesPage(page, pageSize, websiteTag);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      final responseModel = ArticlesPageApiResponse.fromJson(json);
      return PageApiResponse<Article>(
        count: responseModel.count,
        currentPage: responseModel.currentPage,
        pages: responseModel.pages,
        fromCache: false,
        results: responseModel.results,
      );
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<List<ArticleWebsite>> getArticleWebsitesFromRemote() async {
    final response = await tagsApiService.getArticleWebsites();
    if (response.statusCode == 200) {
      final Iterable json = jsonDecode(response.bodyString) as Iterable;
      return json
          .map((site) =>
              ArticleWebsiteModel.fromJson(site as Map<String, dynamic>))
          .toList();
    } else {
      throw ServerFailure(response.error);
    }
  }
}
