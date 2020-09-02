import 'package:chopper/chopper.dart';

import '../../constants/app_constants.dart';

part 'auth_api_service.chopper.dart';

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

  @Post(path: 'social/linkedin/')
  Future<Response> authWithLinkedin(@Body() Map<String, dynamic> body);
}
