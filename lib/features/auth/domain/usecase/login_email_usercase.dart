import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:worknetwork/core/error/failures.dart';
import 'package:worknetwork/core/usecase/aysnc_usecase.dart';
import 'package:worknetwork/features/auth/domain/entity/user_entity.dart';
import 'package:worknetwork/features/auth/domain/repository/auth_repository.dart';

class UCLoginEmail implements AsyncUseCase<User, EmailLoginParams> {
  final AuthRepository repository;

  UCLoginEmail({
    @required this.repository,
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
    this.email,
    this.password,
    this.osId,
  });

  @override
  // TODO: implement props
  List<Object> get props => [email, password, osId];
}
