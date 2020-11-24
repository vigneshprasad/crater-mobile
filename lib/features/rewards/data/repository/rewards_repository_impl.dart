import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network_info/network_info.dart';
import '../../domain/entity/package_entity.dart';
import '../../domain/entity/package_request_entity.dart';
import '../../domain/repository/rewards_repository.dart';
import '../datasources/rewards_local_datasource.dart';
import '../datasources/rewards_remote_datasource.dart';

class RewardsRepositoryImpl implements RewardsRepository {
  final NetworkInfo networkInfo;
  final RewardsLocalDatasource localDatasource;
  final RewardsRemoteDatasource remoteDatasource;

  RewardsRepositoryImpl({
    @required this.networkInfo,
    @required this.localDatasource,
    @required this.remoteDatasource,
  });

  @override
  Future<Either<Failure, List<Package>>> getPackagesList() async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await remoteDatasource.getPackageListFromRemote();
        await localDatasource.persistPackagesToCache(response);
        return Right(response);
      } on ServerException catch (error) {
        return Left(ServerFailure(error));
      }
    } else {
      try {
        final packages = localDatasource.getPackagesFromCache();
        return Right(packages);
      } on CacheException catch (error) {
        return Left(CacheFailure(error));
      }
    }
  }

  @override
  Future<Either<Failure, Package>> getPackage(int packageId) async {
    final isConnected = await networkInfo.isConnected;

    if (isConnected) {
      try {
        final response = await remoteDatasource.getPackageFromRemote(packageId);
        await localDatasource.persistPackageToCache(response);
        return Right(response);
      } on ServerException catch (error) {
        return Left(ServerFailure(error));
      }
    } else {
      try {
        final package = localDatasource.getPackageFromCache(packageId);
        return Right(package);
      } on CacheException catch (error) {
        return Left(CacheFailure(error));
      }
    }
  }

  @override
  Future<Either<Failure, PackageRequest>> postPackageRequest(
    int quantity,
    String requestedBy,
    int package,
    int pointsApplied,
  ) async {
    try {
      final response = await remoteDatasource.postPackageRequestToRemote(
        quantity,
        requestedBy,
        package,
        pointsApplied,
      );
      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(error));
    }
  }
}
