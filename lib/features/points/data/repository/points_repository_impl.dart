import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network_info/network_info.dart';
import '../../domain/entity/points_entity.dart';
import '../../domain/repository/points_repository.dart';
import '../datasources/points_local_datasource.dart';
import '../datasources/points_remote_datasource.dart';

class PointsRepositoryImpl implements PointsRepository {
  final PointsLocalDatasource localDatasource;
  final PointsRemoteDatasource remoteDatasource;
  final NetworkInfo networkInfo;

  PointsRepositoryImpl({
    @required this.localDatasource,
    @required this.remoteDatasource,
    @required this.networkInfo,
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
        return Right(localDatasource.getSelfUserPointsFromCache());
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
