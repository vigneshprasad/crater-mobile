import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../../api/masterclass/masterclass_api_service.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entity/video_entity.dart';
import '../models/video_model.dart';
import '../models/videos_api_response.dart';

abstract class VideoRemoteDatasource {
  Future<VideosApiResponse> getVideosFromRemote(int page);
  Future<Video> getVideoItemFromRemote(int objectId);
}

class VideoRemoteDatasourceImpl implements VideoRemoteDatasource {
  final MasterClassApiService apiService;

  VideoRemoteDatasourceImpl({
    @required this.apiService,
  });

  @override
  Future<VideosApiResponse> getVideosFromRemote(int page) async {
    final response = await apiService.getVideosList(page: page);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return VideosApiResponse.fromJson(json);
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<Video> getVideoItemFromRemote(int objectId) async {
    final response = await apiService.getVideoItem(id: objectId);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return VideoModel.fromJson(json);
    } else {
      throw ServerException(response.error);
    }
  }
}
