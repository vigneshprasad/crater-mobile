import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:worknetwork/core/error/failures.dart';
import 'package:worknetwork/core/usecase/aysnc_usecase.dart';
import 'package:worknetwork/features/videos/domain/entity/video_entity.dart';
import 'package:worknetwork/features/videos/domain/repository/video_repository.dart';

class UCGetVideoItem implements AsyncUseCase<Video, GetVideoItemParams> {
  final VideoRepository repository;

  UCGetVideoItem({
    @required this.repository,
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
