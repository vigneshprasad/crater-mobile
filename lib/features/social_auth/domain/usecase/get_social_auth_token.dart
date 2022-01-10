import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../entity/access_token.dart';
import '../repository/social_auth_repository.dart';

enum SocialAuthProviders {
  google,
  facebook,
  linkedin,
  apple,
  email,
  phone,
}

class UCGetSocialAuthToken
    implements AsyncUseCase<AccessToken, SocialAuthTokenParams> {
  final SocialAuthRepository repository;

  UCGetSocialAuthToken({
    required this.repository,
  });

  @override
  Future<Either<Failure, AccessToken>> call(
      SocialAuthTokenParams params) async {
    switch (params.provider) {
      case SocialAuthProviders.google:
        return repository.getGoogleAccessToken();
      case SocialAuthProviders.facebook:
        return repository.getFacebookAccessToken();
      case SocialAuthProviders.apple:
        return repository.getAppleAccessToken();
      default:
        return Future.value(Left(UnknowSocialProvider()));
    }
  }
}

class SocialAuthTokenParams extends Equatable {
  final SocialAuthProviders provider;

  const SocialAuthTokenParams({
    required this.provider,
  });

  @override
  List<Object> get props => [provider];
}
