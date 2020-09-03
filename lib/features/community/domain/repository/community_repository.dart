import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/page_api_response/page_api_response.dart';
import '../entity/like_entity.dart';
import '../entity/post_entity.dart';

abstract class CommunityRepository {
  Future<Either<Failure, PageApiResponse<Post>>> getPostsPage(
      int pageSize, int page);
  Future<Either<Failure, int>> deletePost(int postId);
  Future<Either<Failure, Like>> createLikeForPost(int postId, String userId);
  Future<Either<Failure, Like>> deleteLikeForPost(int postId);
}
