import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/user_entity.dart';
import '../repository/auth_repository.dart';

class UCGetPersistedUser implements UseCase<User, NoParams> {
  final AuthRepository repository;

  UCGetPersistedUser({
    @required this.repository,
  });

  @override
  Future<Either<Failure, User>> call(NoParams params) {
    return repository.getPersistedUser();
  }
}
