import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:worknetwork/core/error/failures.dart';
import 'package:worknetwork/core/usecase/aysnc_usecase.dart';
import 'package:worknetwork/features/auth/domain/entity/user_entity.dart';
import 'package:worknetwork/features/auth/domain/repository/auth_repository.dart';

class UCPatchUser implements AsyncUseCase<User, PatchUserParams> {
  final AuthRepository repository;

  UCPatchUser({
    @required this.repository,
  });

  @override
  Future<Either<Failure, User>> call(PatchUserParams params) {
    return repository.patchUser(params.user);
  }
}

class PatchUserParams extends Equatable {
  final User user;

  const PatchUserParams({
    @required this.user,
  });

  @override
  List<Object> get props => [user];
}
