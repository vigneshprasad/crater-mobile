import 'dart:convert';

import '../../../../api/tags/tags_api_service.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entity/user_objective_entity.dart';
import '../models/user_objective_model.dart';

abstract class SignupRemoteDatasource {
  Future<List<UserObjective>> getUserObjectivesFromRemote();
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
}
