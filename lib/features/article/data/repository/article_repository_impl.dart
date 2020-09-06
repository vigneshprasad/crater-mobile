import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:worknetwork/core/error/exceptions.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network_info/network_info.dart';
import '../../../../core/page_api_response/page_api_response.dart';
import '../../domain/entity/article_entity.dart';
import '../../domain/repository/article_repository.dart';
import '../datasources/article_local_datasource.dart';
import '../datasources/article_remote_datasource.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final ArticleRemoteDatasource remoteDatasource;
  final ArticleLocalDatasource localDatasource;
  final NetworkInfo networkInfo;

  ArticleRepositoryImpl({
    @required this.remoteDatasource,
    @required this.localDatasource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, PageApiResponse<Article>>> getArticlesPage(
      int page, int pageSize) async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response =
            await remoteDatasource.getArticePageFromRemote(page, pageSize);
        await localDatasource.persistArticlesToCache(response.results);
        return Right(response);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final cached = localDatasource.getAllArticlesFromCache();
        return Right(PageApiResponse<Article>(
          count: cached.length,
          pages: 1,
          currentPage: 1,
          fromCache: true,
          results: cached,
        ));
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
