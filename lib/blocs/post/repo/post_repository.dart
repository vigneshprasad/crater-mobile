import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:worknetwork/api/post/post_api_service.dart';
import 'package:worknetwork/models/post/post_model.dart';

class PostRepository {
  final PostApiService _postApiService = PostApiService.create();
  Box<PostModel> postsBox;

  Future<GetPostListResponse> getPosts() async {
    final response = await _postApiService.getPostList(5, 1);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return GetPostListResponse.fromJson(json);
    } else {
      throw Exception(response.body);
    }
  }

  Future<PostModel> createPost(
      String message, List<MultipartFile> files) async {
    final response = await _postApiService.createPost(message, files);
    if (response.statusCode == 201) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return PostModel.fromJson(json);
    } else {
      throw Exception(response.body);
    }
  }

  Future<void> deletePost(int id) async {
    final response = await _postApiService.deletePost(id);
    if (response.statusCode == 204) {
      return;
    } else {
      throw Exception(response.body);
    }
  }

  void dispose() {
    _postApiService.client.dispose();
  }
}
