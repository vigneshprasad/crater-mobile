import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/user_entity.dart';
import '../repository/auth_repository.dart';

class UCAuthLinkedIn implements UseCase<User, LinkedAuthParams> {
  final AuthRepository repository;

  UCAuthLinkedIn({
    @required this.repository,
  });
  @override
  Future<Either<Failure, User>> call(LinkedAuthParams params) async {
    return repository.authWithLinkedIn(params.token, params.osId);
  }
}

class LinkedAuthParams extends Equatable {
  final String token;
  final String osId;

  const LinkedAuthParams({
    @required this.token,
    @required this.osId,
  });

  @override
  List<Object> get props => [token, osId];
}
