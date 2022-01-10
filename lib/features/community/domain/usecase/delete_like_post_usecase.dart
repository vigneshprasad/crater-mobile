import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../entity/like_entity.dart';
import '../repository/community_repository.dart';

class UCDeleteLikePost implements AsyncUseCase<Like, DeleteLikeParams> {
  final CommunityRepository repository;

  UCDeleteLikePost({
    required this.repository,
  });

  @override
  Future<Either<Failure, Like>> call(DeleteLikeParams params) {
    return repository.deleteLikeForPost(params.postId);
  }
}

class DeleteLikeParams extends Equatable {
  final int postId;

  const DeleteLikeParams({
    required this.postId,
  });

  @override
  List<Object> get props => [postId];
}
