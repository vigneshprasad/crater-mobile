import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network_info/network_info.dart';
import '../../domain/entity/points_entity.dart';
import '../../domain/entity/points_faq_entity.dart';
import '../../domain/entity/points_rule_entity.dart';
import '../../domain/repository/points_repository.dart';
import '../datasources/points_local_datasource.dart';
import '../datasources/points_remote_datasource.dart';

class PointsRepositoryImpl implements PointsRepository {
  final PointsLocalDatasource localDatasource;
  final PointsRemoteDatasource remoteDatasource;
  final NetworkInfo networkInfo;

  PointsRepositoryImpl({
    required this.localDatasource,
    required this.remoteDatasource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Points>> getSelfUserPoints() async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await remoteDatasource.getSelfUserPointsFromRemote();
        return Right(response);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        if (localDatasource.getSelfUserPointsFromCache() != null) {
          return Right(localDatasource.getSelfUserPointsFromCache()!);
        } else {
          return Left(CacheFailure());
        }
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<PointsFaq>>> getPointsFaqList() async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await remoteDatasource.getPointsFaqListFromRemote();
        return Right(response);
      } on ServerException catch (error) {
        return Left(ServerFailure(error));
      }
    } else {
      try {
        final faqs = localDatasource.getPointsFaqFromCache();
        return Right(faqs);
      } on CacheException catch (error) {
        return Left(CacheFailure(error));
      }
    }
  }

  @override
  Future<Either<Failure, List<PointsRule>>> getPointsRuleList() async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await remoteDatasource.getPointsRulesListFromRemote();
        return Right(response);
      } on ServerException catch (error) {
        return Left(ServerFailure(error));
      }
    } else {
      try {
        final rules = localDatasource.getPointsRulesFromCache();
        return Right(rules);
      } on CacheException catch (error) {
        return Left(CacheFailure(error));
      }
    }
  }
}
