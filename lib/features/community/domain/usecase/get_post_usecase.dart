import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:worknetwork/core/error/failures.dart';
import 'package:worknetwork/features/community/domain/repository/community_repository.dart';

import '../../../../core/usecase/aysnc_usecase.dart';
import '../entity/post_entity.dart';

class UCGetPost implements AsyncUseCase<Post, GetPostParams> {
  final CommunityRepository repository;

  UCGetPost(this.repository);

  @override
  Future<Either<Failure, Post>> call(GetPostParams params) {
    return repository.getPost(params.postId);
  }
}

class GetPostParams extends Equatable {
  final int postId;

  const GetPostParams({
    @required this.postId,
  });

  @override
  List<Object> get props => [postId];
}
