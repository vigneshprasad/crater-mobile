import 'dart:convert';

import 'package:worknetwork/api/user/user_api_service.dart';

import '../../../../api/tags/tags_api_service.dart';
import '../../../../core/error/exceptions.dart';
import '../../../auth/data/models/user_tag_model.dart';
import '../../../auth/domain/entity/user_tag_entity.dart';
import '../../domain/entity/user_objective_entity.dart';
import '../models/api_models.dart';
import '../models/user_objective_model.dart';

abstract class SignupRemoteDatasource {
  Future<List<UserObjective>> getUserObjectivesFromRemote();
  Future<List<UserTag>> getUserTagsFromRemote();
  Future<PostPhoneNumberResponse> postNewPhoneNumber(String phoneNumber);
  Future<PostPhoneNumberResponse> postSmsCode(String smsCode);
}

class SignupRemoteDatasourceImpl implements SignupRemoteDatasource {
  final TagsApiService tagsApiService;
  final UserApiService userApiService;

  SignupRemoteDatasourceImpl(this.tagsApiService, this.userApiService);

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

  @override
  Future<PostPhoneNumberResponse> postNewPhoneNumber(String phoneNumber) async {
    final body = {
      "phone_number": phoneNumber,
    };
    final response = await userApiService.postNewPhoneNumber(body);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return PostPhoneNumberResponse.fromJson(json);
    } else {
      throw ServerException(response.error);
    }
  }

  @override
  Future<PostPhoneNumberResponse> postSmsCode(String smsCode) async {
    final body = {
      "sms_code": smsCode,
    };
    final response = await userApiService.postSmsCode(body);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      return PostPhoneNumberResponse.fromJson(json);
    } else {
      throw ServerException(response.error);
    }
  }
}
