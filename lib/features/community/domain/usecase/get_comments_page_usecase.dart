import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/page_api_response/page_api_response.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../entity/comment_entity.dart';
import '../repository/community_repository.dart';

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
    required this.postId,
    required this.page,
    required this.pageSize,
  });

  @override
  List<Object> get props => [
        postId,
        page,
        pageSize,
      ];
}
