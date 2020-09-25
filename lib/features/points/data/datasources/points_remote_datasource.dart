import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../../api/points/points_api_service.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entity/points_entity.dart';
import '../models/points_model.dart';

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
