import 'package:dartz/dartz.dart';
import 'package:worknetwork/features/auth/data/models/user_model.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entity/user_entity.dart';
import '../../domain/repository/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl(this.remoteDataSource, this.localDataSource);

  @override
  Future<Either<Failure, User>> authWithApple(String token, String osId) {
    // TODO: implement authWithApple
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> authWithFacebook(String token, String osId) {
    // TODO: implement authWithFacebook
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> authWithGoogle(
      String token, String osId) async {
    try {
      final response = await remoteDataSource.authWithGoogle(token, osId);
      localDataSource.setUserToCache(response);
      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    }
  }

  @override
  Future<Either<Failure, User>> authWithLinkedIn(
      String token, String osId) async {
    try {
      final response = await remoteDataSource.authWithLinkedIn(token, osId);
      localDataSource.setUserToCache(response);
      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    }
  }

  @override
  Future<Either<Failure, User>> loginwithEmail(
      String email, String password, String osId) async {
    try {
      final response =
          await remoteDataSource.loginWithEmail(email, password, osId);
      localDataSource.setUserToCache(response);
      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    }
  }

  @override
  Future<Either<Failure, User>> registerwithEmail(
      String name, String email, String password, String osId) async {
    try {
      final response =
          await remoteDataSource.registerWithEmail(name, email, password, osId);
      localDataSource.setUserToCache(response);
      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    }
  }

  @override
  Future<Either<Failure, User>> getPersistedUser() {
    try {
      final user = localDataSource.getUserFromCache();
      return Future.value(Right(user));
    } on CacheException {
      return Future.value(Left(CacheFailure()));
    }
  }

  @override
  Future<Either<Failure, User>> patchUser(User user) async {
    try {
      final response =
          await remoteDataSource.patchUserModelRemote(user as UserModel);
      localDataSource.setUserToCache(response as UserModel);
      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    }
  }
}
