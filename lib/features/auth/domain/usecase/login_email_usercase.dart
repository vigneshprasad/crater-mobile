import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../entity/user_entity.dart';
import '../repository/auth_repository.dart';

class UCLoginEmail implements AsyncUseCase<User, EmailLoginParams> {
  final AuthRepository repository;

  UCLoginEmail({
    required this.repository,
  });
  @override
  Future<Either<Failure, User>> call(EmailLoginParams params) {
    return repository.loginwithEmail(
        params.email, params.password, params.osId);
  }
}

class EmailLoginParams extends Equatable {
  final String email;
  final String password;
  final String osId;

  const EmailLoginParams({
    required this.email,
    required this.password,
    required this.osId,
  });

  @override
  // TODO: implement props
  List<Object> get props => [email, password, osId];
}
