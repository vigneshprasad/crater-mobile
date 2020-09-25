import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../entity/user_entity.dart';
import '../repository/auth_repository.dart';

class UCRegisterEmail implements AsyncUseCase<User, RegisterEmailParams> {
  final AuthRepository repository;

  UCRegisterEmail(this.repository);

  @override
  Future<Either<Failure, User>> call(RegisterEmailParams params) {
    return repository.registerwithEmail(
        params.name, params.email, params.password, params.osId);
  }
}

class RegisterEmailParams extends Equatable {
  final String name;
  final String email;
  final String password;
  final String osId;

  const RegisterEmailParams({
    @required this.name,
    @required this.email,
    @required this.password,
    @required this.osId,
  });

  @override
  List<Object> get props => [
        name,
        email,
        password,
      ];
}
