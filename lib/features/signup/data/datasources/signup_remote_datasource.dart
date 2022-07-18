import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/api/user/user_api_service.dart';
import 'package:worknetwork/core/error/exceptions.dart';
import 'package:worknetwork/features/signup/data/models/api_models.dart';

final signupRemoteDatasourceProvider = Provider<SignupRemoteDatasource>((ref) {
  final userApiService = ref.read(userApiServiceProvider);
  return SignupRemoteDatasourceImpl(userApiService);
});

abstract class SignupRemoteDatasource {
  Future<PostPhoneNumberResponse> postNewPhoneNumber(String phoneNumber);
  Future<PostPhoneNumberResponse> postSmsCode(String smsCode);
}

class SignupRemoteDatasourceImpl implements SignupRemoteDatasource {
  final UserApiService userApiService;

  SignupRemoteDatasourceImpl(this.userApiService);

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
