import 'package:chopper/chopper.dart';
import 'package:json_annotation/json_annotation.dart' hide JsonConverter;
import 'package:worknetwork/constants/app_constants.dart';

import 'package:worknetwork/models/user/user_model.dart';

part 'auth_api_service.chopper.dart';
part 'auth_api_service.g.dart';

@JsonSerializable()
class AuthEmailResponse {
  User user;
  String token;

  AuthEmailResponse({
    this.user,
    this.token,
  });

  factory AuthEmailResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthEmailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthEmailResponseToJson(this);
}

@ChopperApi(baseUrl: '/user/auth/')
abstract class AuthApiService extends ChopperService {
  static AuthApiService create() {
    final client = ChopperClient(
      baseUrl: AppConstants.apiBaseUrl,
      services: [
        _$AuthApiService(),
      ],
      converter: const JsonConverter(),
      interceptors: [
        HttpLoggingInterceptor(),
      ],
    );

    return _$AuthApiService(client);
  }

  @Post(path: 'login/')
  Future<Response> loginWithEmail(
    @Body() Map<String, dynamic> body,
  );

  @Post(path: 'social/google/')
  Future<Response> authWithGoogle(@Body() Map<String, dynamic> body);
}
