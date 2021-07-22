import 'dart:convert';

import '../../../../api/points/points_api_service.dart';
import '../../../../api/tags/tags_api_service.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entity/points_entity.dart';
import '../../domain/entity/points_faq_entity.dart';
import '../../domain/entity/points_rule_entity.dart';
import '../models/points_faq_model.dart';
import '../models/points_model.dart';
import '../models/points_rule_model.dart';

abstract class PointsRemoteDatasource {
  Future<Points> getSelfUserPointsFromRemote();
  Future<List<PointsRule>> getPointsRulesListFromRemote();
  Future<List<PointsFaq>> getPointsFaqListFromRemote();
}

class PointsRemoteDatasourceImpl implements PointsRemoteDatasource {
  final PointsApiService apiService;
  final TagsApiService tagsApiService;

  PointsRemoteDatasourceImpl({
    required this.apiService,
    required this.tagsApiService,
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

  @override
  Future<List<PointsFaq>> getPointsFaqListFromRemote() async {
    final response = await tagsApiService.getPointsFaqList();
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Iterable;
      return json
          .map((faq) => PointsFaqModel.fromJson(faq as Map<String, dynamic>))
          .toList();
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<List<PointsRule>> getPointsRulesListFromRemote() async {
    final response = await apiService.getPointsRules();
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Iterable;
      return json
          .map((rule) => PointsRuleModel.fromJson(rule as Map<String, dynamic>))
          .toList();
    } else {
      throw ServerException(response.error);
    }
  }
}
