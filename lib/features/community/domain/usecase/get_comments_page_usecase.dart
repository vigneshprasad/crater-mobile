import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:worknetwork/core/error/failures.dart';

import 'package:worknetwork/core/page_api_response/page_api_response.dart';
import 'package:worknetwork/core/usecase/aysnc_usecase.dart';
import 'package:worknetwork/features/community/domain/entity/comment_entity.dart';
import 'package:worknetwork/features/community/domain/repository/community_repository.dart';

class UCGetCommentsPage
    implements AsyncUseCase<PageApiResponse<Comment>, GetCommentPageParams> {
  final CommunityRepository repository;

  UCGetCommentsPage(this.repository);

  @override
  Future<Either<Failure, PageApiResponse<Comment>>> call(
      GetCommentPageParams params) {
    return repository.getCommentsPage(
        params.postId, params.page, params.pageSize);
  }
}

class GetCommentPageParams extends Equatable {
  final int postId;
  final int page;
  final int pageSize;

  const GetCommentPageParams({
    @required this.postId,
    @required this.page,
    @required this.pageSize,
  });

  @override
  List<Object> get props => [
        postId,
        page,
        pageSize,
      ];
}
