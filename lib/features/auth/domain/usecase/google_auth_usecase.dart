import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../entity/user_entity.dart';
import '../repository/auth_repository.dart';

class UCGoogleAuth extends AsyncUseCase<User, GoogleAuthParams> {
  final AuthRepository repository;

  UCGoogleAuth({
    required this.repository,
  });

  @override
  Future<Either<Failure, User>> call(GoogleAuthParams params) {
    return repository.authWithGoogle(params.token, params.osId);
  }
}

class GoogleAuthParams extends Equatable {
  final String token;
  final String osId;

  const GoogleAuthParams({
    required this.token,
    required this.osId,
  });

  @override
  List<Object> get props => [token, osId];
}
