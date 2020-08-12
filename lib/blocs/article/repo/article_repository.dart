import 'dart:convert';

import 'package:worknetwork/api/articles/articles_api_service.dart';

class ArticleRepository {
  final ArticlesApiService _articlesApiService = ArticlesApiService.create();

  Future<GetArticlesListResponse> getArticlesList() async {
    final response = await _articlesApiService.getArticlesList();
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return GetArticlesListResponse.fromJson(json);
    } else {
      throw Exception(response.body);
    }
  }

  void dispose() {
    _articlesApiService.dispose();
  }
}
