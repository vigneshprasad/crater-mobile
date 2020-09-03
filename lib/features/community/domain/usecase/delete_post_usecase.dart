import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:worknetwork/core/error/failures.dart';
import 'package:worknetwork/core/usecase/aysnc_usecase.dart';
import 'package:worknetwork/features/community/domain/repository/community_repository.dart';

class UCDeletePost implements AsyncUseCase<int, DeletePostParams> {
  final CommunityRepository repository;
  UCDeletePost({
    @required this.repository,
  });

  @override
  Future<Either<Failure, int>> call(DeletePostParams params) {
    return repository.deletePost(params.postId);
  }
}

class DeletePostParams extends Equatable {
  final int postId;

  const DeletePostParams({
    @required this.postId,
  });

  @override
  List<Object> get props => [postId];
}
