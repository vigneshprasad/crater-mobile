import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:worknetwork/features/article/domain/entity/article_entity.dart';

import '../../../../api/articles/articles_api_service.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/page_api_response/page_api_response.dart';
import '../models/api_models.dart';

abstract class ArticleRemoteDatasource {
  Future<PageApiResponse<Article>> getArticePageFromRemote(
      int page, int pageSize);
}

class ArticleRemoteDatasourceImpl implements ArticleRemoteDatasource {
  final ArticlesApiService apiService;

  ArticleRemoteDatasourceImpl({
    @required this.apiService,
  });

  @override
  Future<PageApiResponse<Article>> getArticePageFromRemote(
      int page, int pageSize) async {
    final response = await apiService.getArticlesPage(page, pageSize);
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
}
