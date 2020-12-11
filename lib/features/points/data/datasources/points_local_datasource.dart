import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../../constants/app_hive_boxes.dart';
import '../../../../core/error/exceptions.dart';
import '../../../auth/data/datasources/auth_local_datasource.dart';
import '../../domain/entity/points_entity.dart';
import '../../domain/entity/points_faq_entity.dart';
import '../../domain/entity/points_rule_entity.dart';
import '../models/points_faq_model.dart';
import '../models/points_model.dart';
import '../models/points_rule_model.dart';

abstract class PointsLocalDatasource {
  Points getSelfUserPointsFromCache();
  Future<void> persistSelfUserPointsToCache(Points points);
  List<PointsRule> getPointsRulesFromCache();
  List<PointsFaq> getPointsFaqFromCache();
  Future<void> persistPointsRulesToCache(List<PointsRule> rules);
  Future<void> persistPointsFaqToCache(List<PointsFaq> faqs);
}

class PointsLocalDatasourceImpl implements PointsLocalDatasource {
  final AuthLocalDataSource authLocalDataSource;

  final Box<PointsModel> _box = Hive.box(AppHiveBoxes.pointsBox);
  final Box<PointsRuleModel> _pointsRuleBox =
      Hive.box<PointsRuleModel>(AppHiveBoxes.pointRuleBox);
  final Box<PointsFaqModel> _pointsFaqBox =
      Hive.box<PointsFaqModel>(AppHiveBoxes.pointFaqBox);

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

  @override
  List<PointsFaq> getPointsFaqFromCache() {
    if (_pointsFaqBox.isEmpty) {
      throw CacheException("${_pointsFaqBox.name} is empty");
    }
    return _pointsFaqBox.values.toList();
  }

  @override
  List<PointsRule> getPointsRulesFromCache() {
    if (_pointsRuleBox.isEmpty) {
      throw CacheException("${_pointsRuleBox.name} is empty");
    }
    return _pointsRuleBox.values.toList();
  }

  @override
  Future<void> persistPointsFaqToCache(List<PointsFaq> faqs) async {
    try {
      final Map<String, PointsFaqModel> entries = faqs.fold(
        {},
        (previousValue, element) => {
          element.pk.toString(): element as PointsFaqModel,
          ...previousValue,
        },
      );
      await _pointsFaqBox.putAll(entries);
    } catch (error) {
      throw CacheException(error);
    }
  }

  @override
  Future<void> persistPointsRulesToCache(List<PointsRule> rules) async {
    try {
      final Map<String, PointsRuleModel> entries = rules.fold(
        {},
        (previousValue, element) => {
          element.pointsKey.toString(): element as PointsRuleModel,
          ...previousValue,
        },
      );
      await _pointsRuleBox.putAll(entries);
    } catch (error) {
      throw CacheException(error);
    }
  }
}
