import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:worknetwork/core/error/failures.dart';
import 'package:worknetwork/features/community/domain/repository/community_repository.dart';

import '../../../../core/page_api_response/page_api_response.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../entity/post_entity.dart';

class UCGetPostsPage
    implements AsyncUseCase<PageApiResponse<Post>, GetPostPageParams> {
  final CommunityRepository repository;

  UCGetPostsPage(this.repository);

  @override
  Future<Either<Failure, PageApiResponse<Post>>> call(
      GetPostPageParams params) {
    return repository.getPostsPage(params.pageSize, params.page);
  }
}

class GetPostPageParams extends Equatable {
  final int pageSize;
  final int page;

  const GetPostPageParams({
    this.pageSize,
    this.page,
  });

  @override
  List<Object> get props => [];
}
