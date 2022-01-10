import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/features/auth/domain/entity/user_profile_entity.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entity/profile_entity/profile_entity.dart';
import '../../domain/repository/profile_repository.dart';
import '../datasources/profile_remote_datasource.dart';

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  final remoteDataSource = ref.read(profileRemoteDatasourceProvider);
  return ProfileRepositoryImpl(remoteDataSource);
});

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDatasource remoteDatasource;

  ProfileRepositoryImpl(this.remoteDatasource);

  @override
  Future<Either<Failure, UserProfile>> retrieveProfile(String profileId) async {
    try {
      final response =
          await remoteDatasource.retrieveProfileFromRemote(profileId);
      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(error));
    } on SocketException {
      return Left(ServerFailure("No internet"));
    }
  }

  @override
  Future<Either<Failure, List<Profile>>> retrieveProfiles(
    String tags,
    int page,
    int pageSize,
    String userId,
  ) async {
    try {
      final response = await remoteDatasource.retrieveProfilesFromRemote(
        tags,
        page,
        pageSize,
        userId,
      );
      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(error));
    } on SocketException {
      return Left(ServerFailure("No internet"));
    }
  }

  @override
  Future<Either<Failure, List<Profile>>> retrieveConnections(
      String profileId) async {
    try {
      final response =
          await remoteDatasource.retrieveConnectionsFromRemote(profileId);
      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(error));
    } on SocketException {
      return Left(ServerFailure("No internet"));
    }
  }
}
