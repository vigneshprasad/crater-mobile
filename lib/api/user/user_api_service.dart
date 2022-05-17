import 'package:chopper/chopper.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/config_reader/config_reader.dart';
import '../interceptors/authorized_interceptor.dart';

part 'user_api_service.chopper.dart';

final userApiServiceProvider = Provider((_) => UserApiService.create());

@ChopperApi(baseUrl: '/user/auth/')
abstract class UserApiService extends ChopperService {
  static UserApiService create() {
    final client = ChopperClient(
      baseUrl: ConfigReader.getApiBaseUrl(),
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

  @Get(path: "user/")
  Future<Response> getUser();

  @Get(path: "users/permission")
  Future<Response> getUserPermission();

  @Get(path: "referrals")
  Future<Response> getReferrals(
    @Query() int? page,
    @Query('page_size') int? pageSize,
  );

  @Patch(path: "user/")
  Future<Response> patchUser(@Body() Map<String, dynamic> body);

  @Get(path: "profile/")
  Future<Response> getUserProfile();

  @Post(path: "profile/")
  Future<Response> postUserProfile(@Body() Map<String, dynamic> body);

  @Post(path: "verify/new_phone_number/")
  Future<Response> postNewPhoneNumber(@Body() Map<String, dynamic> body);

  @Post(path: "verify/check_sms_code/")
  Future<Response> postSmsCode(@Body() Map<String, dynamic> body);
}
