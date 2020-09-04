import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:worknetwork/features/community/domain/entity/comment_entity.dart';
import 'package:worknetwork/features/community/domain/entity/like_entity.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network_info/network_info.dart';
import '../../../../core/page_api_response/page_api_response.dart';
import '../../domain/entity/post_entity.dart';
import '../../domain/repository/community_repository.dart';
import '../datasources/community_local_datasource.dart';
import '../datasources/community_remote_datasource.dart';

class CommunityRepositoryImpl implements CommunityRepository {
  final CommunityRemoteDatasource remoteDatasource;
  final CommunityLocalDatasource localDatasource;
  final NetworkInfo networkInfo;

  CommunityRepositoryImpl({
    @required this.remoteDatasource,
    @required this.localDatasource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, PageApiResponse<Post>>> getPostsPage(
      int pageSize, int page) async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response =
            await remoteDatasource.getPostsPageFromRemote(pageSize, page);
        // await localDatasource.persistPostsToCache(response.results);
        return Right(response);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final posts = localDatasource.getPostsfromCache();
        return Right(PageApiResponse<Post>(
          count: posts.length,
          results: posts,
          fromCache: true,
          currentPage: 1,
        ));
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Post>> getPost(int postId) async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await remoteDatasource.getPostFromRemote(postId);
        return Right(response);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final cached = localDatasource.getPostFromCache(postId);
        return Right(cached);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, int>> deletePost(int postId) async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        remoteDatasource.deletePost(postId);
        localDatasource.deletePostfromCache(postId);
        return Right(postId);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    return Left(ServerFailure());
  }

  @override
  Future<Either<Failure, Like>> createLikeForPost(
      int postId, String userId) async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response =
            await remoteDatasource.createLikeForPostRemote(postId, userId);
        return Right(response);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    return Left(ServerFailure());
  }

  @override
  Future<Either<Failure, Like>> deleteLikeForPost(int postId) async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await remoteDatasource.deleteLikeForPostRemote(postId);
        return Right(response);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    return Left(ServerFailure());
  }

  @override
  Future<Either<Failure, PageApiResponse<Comment>>> getCommentsPage(
      int postId, int page, int pageSize) async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await remoteDatasource.getCommentsPageFromRemote(
            postId, page, pageSize);
        return Right(response);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final cached = localDatasource.getCommentsFromCache(postId);
        return Right(PageApiResponse<Comment>(
          count: cached.length,
          results: cached,
          currentPage: 1,
          fromCache: false,
        ));
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Comment>> createCommentForPost(
      String creator, String message, int postId) async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final response = await remoteDatasource.createCommentForPost(
            creator, message, postId);
        return Right(response);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    return Left(ServerFailure());
  }
}
