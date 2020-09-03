import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../entity/like_entity.dart';
import '../repository/community_repository.dart';

class UCCreateLikePost implements AsyncUseCase<Like, CreateLikeParams> {
  final CommunityRepository repository;

  UCCreateLikePost({
    @required this.repository,
  });

  @override
  Future<Either<Failure, Like>> call(CreateLikeParams params) {
    return repository.createLikeForPost(params.post, params.user);
  }
}

class CreateLikeParams extends Equatable {
  final int post;
  final String user;

  const CreateLikeParams({
    this.post,
    this.user,
  });

  @override
  List<Object> get props => [
        post,
        user,
      ];
}
