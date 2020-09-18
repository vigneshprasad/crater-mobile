import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entity/access_token.dart';

abstract class SocialAuthRepository {
  Future<Either<Failure, AccessToken>> getLinkedInAccessToken();
  Future<Either<Failure, AccessToken>> getGoogleAccessToken();
  Future<Either<Failure, AccessToken>> getFacebookAccessToken();
  Future<Either<Failure, AccessToken>> getAppleAccessToken();
}
