import 'package:dartz/dartz.dart';
import 'package:worknetwork/features/social_auth/data/datasources/social_auth_remote_datasource.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entity/access_token.dart';
import '../../domain/repository/social_auth_repository.dart';

class SocialAuthRepositoryImpl implements SocialAuthRepository {
  final SocialAuthRemoteDataSource remoteDataSource;

  SocialAuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, AccessToken>> getAppleAccessToken() async {
    return _getToken(remoteDataSource.getAppleAccessToken);
  }

  @override
  Future<Either<Failure, AccessToken>> getFacebookAccessToken() {
    return _getToken(remoteDataSource.getFacebookAccessToken);
  }

  @override
  Future<Either<Failure, AccessToken>> getGoogleAccessToken() {
    return _getToken(remoteDataSource.getGoogleAccessToken);
  }

  @override
  Future<Either<Failure, AccessToken>> getLinkedInAccessToken() {
    return _getToken(remoteDataSource.getLinkedInAccessToken);
  }

  Future<Either<Failure, AccessToken>> _getToken(
      Future<AccessToken> Function() callback) async {
    try {
      final token = await callback();
      return Right(token);
    } on Exception {
      return Left(ServerFailure());
    }
  }
}
