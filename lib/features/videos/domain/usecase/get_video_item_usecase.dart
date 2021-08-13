import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../entity/video_entity.dart';
import '../repository/video_repository.dart';

class UCGetVideoItem implements AsyncUseCase<Video, GetVideoItemParams> {
  final VideoRepository repository;

  UCGetVideoItem({
    required this.repository,
  });

  @override
  Future<Either<Failure, Video>> call(GetVideoItemParams params) {
    return repository.getVideoItem(params.objectId);
  }
}

class GetVideoItemParams extends Equatable {
  final int objectId;

  const GetVideoItemParams(this.objectId);

  @override
  List<Object> get props => [objectId];
}
