import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network_info/network_info.dart';
import '../../../../core/page_api_response/page_api_response.dart';
import '../../domain/entity/video_entity.dart';
import '../../domain/repository/video_repository.dart';
import '../datasources/video_remote_datasource.dart';
import '../datasources/videos_local_datasource.dart';

const VIDEOS_PAGE_SIZE = 5;

class VideoRepositoryImpl implements VideoRepository {
  final NetworkInfo networkInfo;
  final VideoLocalDataSource localDataSource;
  final VideoRemoteDatasource remoteDatasource;

  VideoRepositoryImpl({
    @required this.networkInfo,
    @required this.localDataSource,
    @required this.remoteDatasource,
  });

  @override
  Future<Either<Failure, PageApiResponse<Video>>> getVideosPage(
      int page) async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await remoteDatasource.getVideosFromRemote(page);
        final pages = (response.count / VIDEOS_PAGE_SIZE).floor();
        return Right(PageApiResponse(
          fromCache: false,
          count: response.count,
          pages: pages,
          results: response.results,
          currentPage: page,
        ));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final cached = localDataSource.getAllVideosFromCache();
        final pages = (cached.length / VIDEOS_PAGE_SIZE).floor();
        return Right(PageApiResponse(
          fromCache: true,
          count: cached.length,
          pages: pages,
          results: cached,
          currentPage: page,
        ));
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Video>> getVideoItem(int objectId) async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response =
            await remoteDatasource.getVideoItemFromRemote(objectId);
        return Right(response);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final cache = localDataSource.getVideoItemfromCache(objectId);
        return Right(cache);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
