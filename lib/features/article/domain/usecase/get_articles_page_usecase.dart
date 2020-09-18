import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:worknetwork/features/article/domain/repository/article_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/page_api_response/page_api_response.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../entity/article_entity.dart';

class UCGetArticlesPage
    implements AsyncUseCase<PageApiResponse<Article>, GetArticlesPageParams> {
  final ArticleRepository repository;

  UCGetArticlesPage(this.repository);

  @override
  Future<Either<Failure, PageApiResponse<Article>>> call(
      GetArticlesPageParams params) {
    return repository.getArticlesPage(params.page, params.pageSize);
  }
}

class GetArticlesPageParams extends Equatable {
  final int page;
  final int pageSize;

  const GetArticlesPageParams({
    @required this.page,
    @required this.pageSize,
  });

  @override
  List<Object> get props => [page, pageSize];
}
