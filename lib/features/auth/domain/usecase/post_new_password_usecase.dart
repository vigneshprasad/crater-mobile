import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../repository/auth_repository.dart';

class UCPostNewPassword implements AsyncUseCase<String, PostNewPasswordParams> {
  final AuthRepository repository;

  UCPostNewPassword(this.repository);

  @override
  Future<Either<Failure, String>> call(PostNewPasswordParams params) {
    return repository.postNewPassword(params.body);
  }
}

class PostNewPasswordParams extends Equatable {
  final Map<String, String> body;

  const PostNewPasswordParams({
    @required this.body,
  });

  @override
  List<Object> get props => [body];
}
