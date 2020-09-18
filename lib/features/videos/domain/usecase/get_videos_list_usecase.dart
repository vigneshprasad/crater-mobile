import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:worknetwork/features/videos/domain/repository/video_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/page_api_response/page_api_response.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../entity/video_entity.dart';

class UCGetVideosListPage
    implements AsyncUseCase<PageApiResponse<Video>, GetVideosPageParams> {
  final VideoRepository repository;

  UCGetVideosListPage({
    @required this.repository,
  });

  @override
  Future<Either<Failure, PageApiResponse<Video>>> call(
      GetVideosPageParams params) {
    return repository.getVideosPage(params.page);
  }
}

class GetVideosPageParams extends Equatable {
  final int page;
  final int pageSize;

  const GetVideosPageParams({
    @required this.page,
    @required this.pageSize,
  });

  @override
  List<Object> get props => [];
}
