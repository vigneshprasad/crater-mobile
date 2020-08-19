import 'package:chopper/chopper.dart';
import 'package:worknetwork/constants/app_constants.dart';

part 'auth_api_service.chopper.dart';

@ChopperApi(baseUrl: '/user/auth/')
abstract class AuthApiService extends ChopperService {
  static AuthApiService create([ChopperClient client]) =>
      _$AuthApiService(client);

  @Post(path: 'login/')
  Future<Response> loginWithEmail(
    @Body() Map<String, dynamic> body,
  );

  @Post(path: 'social/google/')
  Future<Response> authWithGoogle(@Body() Map<String, dynamic> body);

  @Post(path: 'social/linkedin/')
  Future<Response> authWithLinkedin(@Body() Map<String, dynamic> body);
}

class AuthApiServiceImpl implements AuthApiService {
  @override
  ChopperClient client = ChopperClient(
    baseUrl: AppConstants.apiBaseUrl,
    services: [
      AuthApiService.create(),
    ],
    converter: const JsonConverter(),
    interceptors: [
      HttpLoggingInterceptor(),
    ],
  );

  @override
  Future<Response> authWithGoogle(Map<String, dynamic> body) {
    return client.getService<AuthApiService>().authWithGoogle(body);
  }

  @override
  Future<Response> authWithLinkedin(Map<String, dynamic> body) {
    return client.getService<AuthApiService>().authWithLinkedin(body);
  }

  @override
  Type get definitionType => AuthApiService;

  @override
  void dispose() {
    client.dispose();
  }

  @override
  Future<Response> loginWithEmail(Map<String, dynamic> body) {
    return client.getService<AuthApiService>().loginWithEmail(body);
  }
}
