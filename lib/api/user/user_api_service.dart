import 'package:chopper/chopper.dart';

import '../../constants/app_constants.dart';
import '../interceptors/authorized_interceptor.dart';

part 'user_api_service.chopper.dart';

@ChopperApi(baseUrl: '/user/auth/')
abstract class UserApiService extends ChopperService {
  static UserApiService create() {
    final client = ChopperClient(
      baseUrl: AppConstants.apiBaseUrl,
      services: [
        _$UserApiService(),
      ],
      interceptors: [
        AuthorizedInterceptor(),
      ],
      converter: const JsonConverter(),
    );
    return _$UserApiService(client);
  }

  @Patch(path: 'user/')
  Future<Response> patchUser(@Body() Map<String, dynamic> body);
}
