import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:worknetwork/api/points/points_api_service.dart';
import 'package:worknetwork/core/error/exceptions.dart';
import 'package:worknetwork/features/points/data/models/points_model.dart';
import 'package:worknetwork/features/points/domain/entity/points_entity.dart';

abstract class PointsRemoteDatasource {
  Future<Points> getSelfUserPointsFromRemote();
}

class PointsRemoteDatasourceImpl implements PointsRemoteDatasource {
  final PointsApiService apiService;

  PointsRemoteDatasourceImpl({
    @required this.apiService,
  });

  @override
  Future<Points> getSelfUserPointsFromRemote() async {
    try {
      final response = await apiService.getSelfUserPoints();
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return PointsModel.fromJson(json);
    } catch (error) {
      throw ServerException(error);
    }
  }
}
