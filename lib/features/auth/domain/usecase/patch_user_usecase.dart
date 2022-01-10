import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../entity/user_entity.dart';
import '../repository/auth_repository.dart';

class UCPatchUser implements AsyncUseCase<User, PatchUserParams> {
  final AuthRepository repository;

  UCPatchUser({
    required this.repository,
  });

  @override
  Future<Either<Failure, User>> call(PatchUserParams params) {
    return repository.patchUser(params.user);
  }
}

class PatchUserParams extends Equatable {
  final User user;

  const PatchUserParams({
    required this.user,
  });

  @override
  List<Object> get props => [user];
}
