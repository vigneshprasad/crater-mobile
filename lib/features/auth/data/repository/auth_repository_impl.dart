import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/features/auth/data/models/api/referrals_response_model.dart';
import 'package:worknetwork/features/conversations/domain/entity/conversation_entity/conversation_entity.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network_info/network_info.dart';
import '../../domain/entity/user_entity.dart';
import '../../domain/entity/user_profile_entity.dart';
import '../../domain/repository/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/user_model.dart';
import '../models/user_profile_model.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final remoteDataSource = ref.read(authRemoteDatasourceProvider);
  final localDataSource = ref.read(authLocalDatasourceProvider);
  final networkInfo = ref.read(networkInfoProvider);
  return AuthRepositoryImpl(remoteDataSource, localDataSource, networkInfo);
});

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl(
      this.remoteDataSource, this.localDataSource, this.networkInfo);

  @override
  Future<Either<Failure, User>> authWithApple(String token, String osId) async {
    try {
      final response = await remoteDataSource.authWithApple(token, osId);
      localDataSource.setUserToCache(response);
      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    }
  }

  @override
  Future<Either<Failure, User>> authWithFacebook(
      String token, String osId) async {
    try {
      final response = await remoteDataSource.authWithFacebook(token, osId);
      localDataSource.setUserToCache(response);
      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    }
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
  Future<Either<Failure, bool>> getAuthenticationState() {
    try {
      final user = localDataSource.getUserFromCache();
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
      localDataSource.updateUserToCache(response as UserModel);
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
        return Right(response);
      } on ServerException catch (error) {
        return Left(ServerFailure(error.message));
      }
    } else {
      try {
        final response = localDataSource.getUserFromCache();
        await localDataSource.updateUserToCache(response);
        return Right(response);
      } on CacheException catch (error) {
        return Left(CacheFailure(error.message));
      }
    }
  }

  @override
  Future<Either<Failure, UserProfile>> postUserProfile(
      Map<String, dynamic> body) async {
    try {
      final response = await remoteDataSource.postUserProfileRemote(body);
      await localDataSource.setUserProfileToCache(response as UserProfileModel);
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
        await localDataSource
            .setUserProfileToCache(response as UserProfileModel);
        return Right(response);
      } on ServerException catch (error) {
        return Left(ServerFailure(error.message));
      }
    } else {
      try {
        final cached = localDataSource.getUserProfileFromCache();
        return Right(cached);
      } on CacheException catch (error) {
        return Left(CacheFailure(error.message));
      }
    }
  }

  @override
  Future<Either<Failure, String>> postPasswordReset(String email) async {
    try {
      final response = await remoteDataSource.postPasswordResetToRemote(email);
      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(error));
    }
  }

  @override
  Future<Either<Failure, String>> postNewPassword(
      Map<String, String> body) async {
    try {
      final response = await remoteDataSource.postNewPasswordToRemote(body);
      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(error));
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
      String phone, String otp, Map<String, String> attributionData) async {
    try {
      final response =
          await remoteDataSource.verifyOtp(phone, otp, attributionData);
      localDataSource.setUserToCache(response);
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
      int? page, int? pageSize) async {
    try {
      final response =
          await remoteDataSource.getReferralsFromRemote(page, pageSize);
      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    }
  }
}
