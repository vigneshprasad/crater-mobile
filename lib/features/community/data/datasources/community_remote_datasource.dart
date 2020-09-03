import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:worknetwork/core/error/exceptions.dart';
import 'package:worknetwork/features/community/data/models/api_models.dart';

import '../../../../api/post/post_api_service.dart';
import '../../../../core/page_api_response/page_api_response.dart';
import '../../domain/entity/post_entity.dart';

abstract class CommunityRemoteDatasource {
  Future<PageApiResponse<Post>> getPostsPageFromRemote(int pageSize, int page);
  Future<void> deletePost(int postId);
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
  Future<void> deletePost(int postId) async {
    final response = await apiService.deletePost(postId);
    if (response.statusCode != 204) {
      throw ServerException(response.error);
    }
  }
}
