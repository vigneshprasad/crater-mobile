import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/user_entity.dart';
import '../repository/auth_repository.dart';

class UCGoogleAuth extends UseCase<User, GoogleAuthParams> {
  final AuthRepository repository;

  UCGoogleAuth({
    @required this.repository,
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
    this.token,
    this.osId,
  });

  @override
  List<Object> get props => [token, osId];
}
