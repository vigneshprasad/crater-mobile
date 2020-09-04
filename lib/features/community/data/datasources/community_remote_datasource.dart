import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:worknetwork/features/community/data/models/comment_model.dart';
import 'package:worknetwork/features/community/data/models/post_model.dart';

import '../../../../api/post/post_api_service.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/page_api_response/page_api_response.dart';
import '../../domain/entity/comment_entity.dart';
import '../../domain/entity/like_entity.dart';
import '../../domain/entity/post_entity.dart';
import '../models/api_models.dart';
import '../models/like_model.dart';

abstract class CommunityRemoteDatasource {
  Future<PageApiResponse<Post>> getPostsPageFromRemote(int pageSize, int page);
  Future<Post> getPostFromRemote(int postId);
  Future<void> deletePost(int postId);
  Future<Like> createLikeForPostRemote(int postId, String userId);
  Future<Like> deleteLikeForPostRemote(int postId);
  Future<PageApiResponse<Comment>> getCommentsPageFromRemote(
      int postId, int page, int pageSize);
  Future<Comment> createCommentForPost(
      String creator, String message, int postId);
}

class CommunityRemoteDatasourceImpl implements CommunityRemoteDatasource {
  final PostApiService apiService;

  CommunityRemoteDatasourceImpl({
    @required this.apiService,
  });

  @override
  Future<PageApiResponse<Post>> getPostsPageFromRemote(
      int pageSize, int page) async {
    final response = await apiService.getPostList(pageSize, page);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      final responseModel = PostsPageApiResponse.fromJson(json);
      final pages = (responseModel.count / pageSize).ceil();
      return PageApiResponse<Post>(
        count: responseModel.count,
        currentPage: responseModel.currentPage,
        results: responseModel.results.cast<Post>(),
        fromCache: false,
        pages: pages,
      );
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<Post> getPostFromRemote(int postId) async {
    final response = await apiService.getPost(postId);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return PostModel.fromJson(json);
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<void> deletePost(int postId) async {
    final response = await apiService.deletePost(postId);
    if (response.statusCode != 204) {
      throw ServerException(response.error);
    }
  }

  @override
  Future<Like> createLikeForPostRemote(int postId, String userId) async {
    final body = {
      "post": postId.toString(),
      "user": userId,
    };
    final response = await apiService.createLike(body);
    if (response.statusCode == 201) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return LikeModel.fromJson(json);
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<Like> deleteLikeForPostRemote(int postId) async {
    final response = await apiService.deleteLike(postId);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return LikeModel.fromJson(json);
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<PageApiResponse<Comment>> getCommentsPageFromRemote(
      int postId, int page, int pageSize) async {
    const offset = 0;
    final response =
        await apiService.getCommentsPage(postId, pageSize, page, offset);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      final responseModel = CommentsPageApiResponse.fromJson(json);
      final pages = (responseModel.results.length / pageSize).ceil();
      final resultsUpdated =
          responseModel.results.map((e) => e.copyWith(postId: postId)).toList();
      return PageApiResponse<Comment>(
        count: responseModel.count,
        currentPage: responseModel.currentPage,
        results: resultsUpdated,
        fromCache: false,
        pages: pages,
      );
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<Comment> createCommentForPost(
      String creator, String message, int postId) async {
    final body = {
      "creator": creator,
      "message": message,
      "post": postId.toString(),
    };
    final response = await apiService.createCommentForPost(body);
    if (response.statusCode == 201) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      final comment = CommentModel.fromJson(json).copyWith(postId: postId);
      return comment;
    } else {
      throw ServerException(response.error);
    }
  }
}
