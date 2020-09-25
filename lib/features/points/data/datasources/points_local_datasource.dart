import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../../constants/app_hive_boxes.dart';
import '../../../../core/error/exceptions.dart';
import '../../../auth/data/datasources/auth_local_datasource.dart';
import '../../domain/entity/points_entity.dart';
import '../models/points_model.dart';

abstract class PointsLocalDatasource {
  Points getSelfUserPointsFromCache();
  Future<void> persistSelfUserPointsToCache(Points points);
}

class PointsLocalDatasourceImpl implements PointsLocalDatasource {
  final Box<PointsModel> _box = Hive.box(AppHiveBoxes.pointsBox);
  final AuthLocalDataSource authLocalDataSource;

  PointsLocalDatasourceImpl({
    @required this.authLocalDataSource,
  });

  @override
  Points getSelfUserPointsFromCache() {
    if (_box.isEmpty) throw CacheException("Empty points data from cache.");
    try {
      final user = authLocalDataSource.getUserFromCache();
      return _box.get(user.pk);
    } catch (error) {
      throw CacheException(error);
    }
  }

  @override
  Future<void> persistSelfUserPointsToCache(Points points) async {
    try {
      final user = authLocalDataSource.getUserFromCache();
      await _box.put(user.pk, points as PointsModel);
    } catch (error) {
      throw CacheException(error);
    }
  }
}
