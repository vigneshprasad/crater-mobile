import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../entity/user_entity.dart';
import '../repository/auth_repository.dart';

class UCGetPersistedUser implements AsyncUseCase<User, NoParams> {
  final AuthRepository repository;

  UCGetPersistedUser({
    @required this.repository,
  });

  @override
  Future<Either<Failure, User>> call(NoParams params) {
    return repository.getPersistedUser();
  }
}
