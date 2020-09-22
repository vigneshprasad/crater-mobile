import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../entity/article_website_entity.dart';
import '../repository/article_repository.dart';

class UCGetArticleWebsites
    implements AsyncUseCase<List<ArticleWebsite>, NoParams> {
  final ArticleRepository repository;

  UCGetArticleWebsites(this.repository);

  @override
  Future<Either<Failure, List<ArticleWebsite>>> call(NoParams params) {
    return repository.getArticleWebsites();
  }
}
