import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/page_api_response/page_api_response.dart';
import '../entity/video_entity.dart';

abstract class VideoRepository {
  Future<Either<Failure, PageApiResponse<Video>>> getVideosPage(int page);
  Future<Either<Failure, Video>> getVideoItem(int objectId);
}
