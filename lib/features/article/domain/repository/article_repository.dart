import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/page_api_response/page_api_response.dart';
import '../entity/article_entity.dart';
import '../entity/article_website_entity.dart';

abstract class ArticleRepository {
  Future<Either<Failure, PageApiResponse<Article>>> getArticlesPage(
      int page, int pageSize, int websiteTag);
  Future<Either<Failure, List<ArticleWebsite>>> getArticleWebsites();
}
