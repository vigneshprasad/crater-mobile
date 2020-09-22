import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../entity/user_entity.dart';
import '../repository/auth_repository.dart';

class UCAuthWithApple implements AsyncUseCase<User, AppleAuthParams> {
  final AuthRepository repository;

  UCAuthWithApple(this.repository);

  @override
  Future<Either<Failure, User>> call(AppleAuthParams params) {
    return repository.authWithApple(params.token, params.osId);
  }
}

class AppleAuthParams extends Equatable {
  final String token;
  final String osId;

  const AppleAuthParams({
    @required this.token,
    @required this.osId,
  });

  @override
  List<Object> get props => [token, osId];
}
