import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:kiwi/kiwi.dart';
import 'package:worknetwork/features/roundtable/data/models/roundtable_meta_api_response/roundtable_meta_api_response.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures/failures.dart';
import '../../../../core/network_info/network_info.dart';
import '../../domain/entity/category_entity/category_entity.dart';
import '../../domain/entity/roundtable_entity/roundtable_entity.dart';
import '../../domain/repository/roundtable_repository.dart';
import '../datasources/roundtable_local_datasource.dart';
import '../datasources/roundtable_remote_datasource.dart';

final roundtableRepositoryProvider = Provider<RoundTableRepository>((ref) {
  final localDatasource = ref.read(roundtableLocalDatasourceProvider);
  final remoteDatasource = ref.read(roundTableRemoteDatasourceProvider);
  final networkInfo = KiwiContainer().resolve<NetworkInfo>();
  return RoundTableRepositoryImpl(
      localDatasource, remoteDatasource, networkInfo);
});

class RoundTableRepositoryImpl implements RoundTableRepository {
  final RoundTableLocalDatasource _localDatasource;
  final RoundTableRemoteDatasource _remoteDatasource;
  final NetworkInfo _networkInfo;

  RoundTableRepositoryImpl(
    this._localDatasource,
    this._remoteDatasource,
    this._networkInfo,
  );

  @override
  Future<Either<Failure, List<Category>>> getAllRoundTableCategories() async {
    try {
      final response =
          await _remoteDatasource.getAllRoundTableCategoriesFromRemote();
      return Right(response);
    } on ServerException catch (error) {
      final message = error.message as Map<String, dynamic>;
      final failure = ServerFailure(message: "Something went wrong");
      return Left(failure);
    } on SocketException {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<Category>>> getMyRoundTableCategories() async {
    try {
      final response =
          await _remoteDatasource.getMyRoundTableCategoriesFromRemote();
      return Right(response);
    } on ServerException catch (error) {
      final message = error.message as Map<String, dynamic>;
      final failure = ServerFailure(message: "Something went wrong");
      return Left(failure);
    } on SocketException {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<Category>>>
      getUpcomingRoundTableCategories() async {
    try {
      final response =
          await _remoteDatasource.getUpcomingRoundTableCategoriesFromRemote();
      return Right(response);
    } on ServerException catch (error) {
      final message = error.message as Map<String, dynamic>;
      final failure = ServerFailure(message: "Something went wrong");
      return Left(failure);
    } on SocketException {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<RoundTable>>> getAllRoundTables() async {
    try {
      final response = await _remoteDatasource.getRoundTablesFromRemote();
      return Right(response);
    } on ServerException catch (error) {
      final message = error.message as Map<String, dynamic>;
      final failure = ServerFailure(message: "Something went wrong");
      return Left(failure);
    } on SocketException {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<RoundTable>>> getAllMyRoundTables() async {
    try {
      final response = await _remoteDatasource.getMyRoundTablesFromRemote();
      return Right(response);
    } on ServerException catch (error) {
      final message = error.message as Map<String, dynamic>;
      final failure = ServerFailure(message: "Something went wrong");
      return Left(failure);
    } on SocketException {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, RoundTableMetaApiResponse>>
      getRoundTableMetaInfo() async {
    try {
      final response = await _remoteDatasource.getRoundTableMetaFromRemote();
      return Right(response);
    } on ServerException catch (error) {
      final message = error.message as Map<String, dynamic>;
      final failure = ServerFailure(message: "Something went wrong");
      return Left(failure);
    } on SocketException {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, RoundTable>> retrieveRoundTable(int id) async {
    try {
      final response = await _remoteDatasource.retrieveRoundTableFromRemote(id);
      return Right(response);
    } on ServerException catch (error) {
      final message = error.message as Map<String, dynamic>;
      final failure = ServerFailure(message: "Something went wrong");
      return Left(failure);
    } on SocketException {
      return Left(NetworkFailure());
    }
  }
}
