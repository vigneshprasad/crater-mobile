import 'dart:convert';

import 'package:worknetwork/features/auth/data/models/user_tag_model.dart';
import 'package:worknetwork/features/auth/domain/entity/user_tag_entity.dart';

import '../../../../api/tags/tags_api_service.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entity/user_objective_entity.dart';
import '../models/user_objective_model.dart';

abstract class SignupRemoteDatasource {
  Future<List<UserObjective>> getUserObjectivesFromRemote();
  Future<List<UserTag>> getUserTagsFromRemote();
}

class SignupRemoteDatasourceImpl implements SignupRemoteDatasource {
  final TagsApiService tagsApiService;

  SignupRemoteDatasourceImpl(this.tagsApiService);

  @override
  Future<List<UserObjective>> getUserObjectivesFromRemote() async {
    final response = await tagsApiService.getUserObjectives();
    if (response.statusCode == 200) {
      final Iterable json = jsonDecode(response.bodyString) as Iterable;
      return json
          .map((e) => UserObjectiveModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<List<UserTag>> getUserTagsFromRemote() async {
    final response = await tagsApiService.getUserTags();
    if (response.statusCode == 200) {
      final Iterable list = jsonDecode(response.bodyString) as Iterable;
      return list
          .map((e) => UserTagModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw ServerException(response.error);
    }
  }
}
