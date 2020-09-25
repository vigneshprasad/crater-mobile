import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/page_api_response/page_api_response.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../entity/article_entity.dart';
import '../repository/article_repository.dart';

class UCGetArticlesPage
    implements AsyncUseCase<PageApiResponse<Article>, GetArticlesPageParams> {
  final ArticleRepository repository;

  UCGetArticlesPage(this.repository);

  @override
  Future<Either<Failure, PageApiResponse<Article>>> call(
      GetArticlesPageParams params) {
    return repository.getArticlesPage(
        params.page, params.pageSize, params.websiteTag);
  }
}

class GetArticlesPageParams extends Equatable {
  final int websiteTag;
  final int page;
  final int pageSize;

  const GetArticlesPageParams({
    @required this.websiteTag,
    @required this.page,
    @required this.pageSize,
  });

  @override
  List<Object> get props => [page, pageSize];
}
