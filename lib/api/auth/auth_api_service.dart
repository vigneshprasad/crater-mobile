import 'package:chopper/chopper.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/api/interceptors/authorized_interceptor.dart';

import 'package:worknetwork/core/config_reader/config_reader.dart';

part 'auth_api_service.chopper.dart';

final authApiServiceProvider =
    Provider<AuthApiService>((ref) => AuthApiService.create(ref.read));

@ChopperApi(baseUrl: '/user/auth/')
abstract class AuthApiService extends ChopperService {
  static AuthApiService create(Reader read) {
    final client = ChopperClient(
      baseUrl: ConfigReader.getApiBaseUrl(),
      services: [
        _$AuthApiService(),
      ],
      converter: const JsonConverter(),
      interceptors: [
        HttpLoggingInterceptor(),
        read(authInterceptorProvider),
      ],
    );
    return _$AuthApiService(client);
  }

  @Post(path: 'logout/')
  Future<Response> logout(@Body() Map<String, dynamic> body);
}
