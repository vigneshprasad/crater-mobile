import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/core/error/exceptions.dart';
import 'package:worknetwork/core/error/failures/failures.dart';
import 'package:worknetwork/core/network_info/network_info.dart';
import 'package:worknetwork/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:worknetwork/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:worknetwork/features/auth/data/models/api/referrals_response_model.dart';
import 'package:worknetwork/features/auth/data/models/user_model.dart';
import 'package:worknetwork/features/auth/data/models/user_profile_model.dart';
import 'package:worknetwork/features/auth/domain/entity/user_entity.dart';
import 'package:worknetwork/features/auth/domain/entity/user_profile_entity.dart';
import 'package:worknetwork/features/auth/domain/repository/auth_repository.dart';
import 'package:worknetwork/features/conversations/domain/entity/conversation_entity/conversation_entity.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final remoteDataSource = ref.read(authRemoteDatasourceProvider);
  final localDataSource = ref.read(authLocalDatasourceProvider.future);
  final networkInfo = ref.read(networkInfoProvider);
  return AuthRepositoryImpl(remoteDataSource, localDataSource, networkInfo);
});

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final Future<AuthLocalDataSource> localDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl(
    this.remoteDataSource,
    this.localDataSource,
    this.networkInfo,
  );

  @override
  Future<Either<Failure, User>> logout(String osId) async {
    try {
      final response = await remoteDataSource.logout(osId);
      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    }
  }

  @override
  Future<Either<Failure, bool>> getAuthenticationState() async {
    try {
      final user = (await localDataSource).getUserFromCache();
      return Future.value(Right(user.token != null));
    } on CacheException {
      return Future.value(Left(CacheFailure()));
    }
  }

  @override
  Future<Either<Failure, User>> patchUser(User user) async {
    try {
      final response =
          await remoteDataSource.patchUserModelRemote(user as UserModel);
      await (await localDataSource).updateUserToCache(response as UserModel);
      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    }
  }

  @override
  Future<Either<Failure, User>> getUser() async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await remoteDataSource.getUserFromRemote();
        await (await localDataSource).updateUserToCache(response as UserModel);
        return Right(response);
      } on ServerException catch (error) {
        return Left(ServerFailure(error.message));
      }
    } else {
      try {
        final response = (await localDataSource).getUserFromCache();
        return Right(response);
      } on CacheException catch (error) {
        return Left(CacheFailure(message: error.message));
      }
    }
  }

  @override
  Future<Either<Failure, UserProfile>> postUserProfile(
    Map<String, dynamic> body,
  ) async {
    try {
      final response = await remoteDataSource.postUserProfileRemote(body);
      await (await localDataSource)
          .setUserProfileToCache(response as UserProfileModel);
      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    }
  }

  @override
  Future<Either<Failure, UserProfile>> getUserProfile() async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await remoteDataSource.getUserProfileFromRemote();
        await (await localDataSource)
            .setUserProfileToCache(response as UserProfileModel);
        return Right(response);
      } on ServerException catch (error) {
        return Left(ServerFailure(error.message));
      }
    } else {
      try {
        final cached = (await localDataSource).getUserProfileFromCache();
        return Right(cached);
      } on CacheException catch (error) {
        return Left(CacheFailure(message: error.message));
      }
    }
  }

  @override
  Future<Either<Failure, void>> sendOtp(String phone) async {
    try {
      final response = await remoteDataSource.sendOtp(phone);
      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(error));
    }
  }

  @override
  Future<Either<Failure, User>> verifyOtp(
    String phone,
    String otp,
    Map<String, String> attributionData,
  ) async {
    try {
      final response =
          await remoteDataSource.verifyOtp(phone, otp, attributionData);
      await (await localDataSource).setUserToCache(response);
      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(error));
    }
  }

  @override
  Future<Either<Failure, UserPermission>> getUserPermission() async {
    try {
      final response = await remoteDataSource.getUserPermissionFromRemote();
      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    }
  }

  @override
  Future<Either<Failure, ReferralsResponse>> getReferrals(
    int? page,
    int? pageSize,
  ) async {
    try {
      final response =
          await remoteDataSource.getReferralsFromRemote(page, pageSize);
      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    }
  }
}
