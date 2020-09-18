import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../entity/comment_entity.dart';
import '../repository/community_repository.dart';

class UCCreateCommentPost
    implements AsyncUseCase<Comment, CreateCommentPostParams> {
  final CommunityRepository repository;

  UCCreateCommentPost(this.repository);

  @override
  Future<Either<Failure, Comment>> call(CreateCommentPostParams params) {
    return repository.createCommentForPost(
        params.creator, params.message, params.post);
  }
}

class CreateCommentPostParams extends Equatable {
  final String creator;
  final String message;
  final int post;

  const CreateCommentPostParams({
    @required this.creator,
    @required this.message,
    @required this.post,
  });

  @override
  List<Object> get props => [
        creator,
        message,
        post,
      ];
}
