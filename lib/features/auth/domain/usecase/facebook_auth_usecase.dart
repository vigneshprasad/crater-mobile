import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:worknetwork/core/error/failures.dart';
import 'package:worknetwork/core/usecase/aysnc_usecase.dart';
import 'package:worknetwork/features/auth/domain/entity/user_entity.dart';
import 'package:worknetwork/features/auth/domain/repository/auth_repository.dart';

class UCFacebookAuth implements AsyncUseCase<User, FacebookAuthParams> {
  final AuthRepository repository;

  UCFacebookAuth(this.repository);

  @override
  Future<Either<Failure, User>> call(FacebookAuthParams params) {
    return repository.authWithFacebook(params.token, params.osId);
  }
}

class FacebookAuthParams extends Equatable {
  final String token;
  final String osId;

  const FacebookAuthParams({
    this.token,
    this.osId,
  });

  @override
  List<Object> get props => [token, osId];
}
