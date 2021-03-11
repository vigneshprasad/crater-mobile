import 'package:chopper/chopper.dart';

import '../../core/config_reader/config_reader.dart';
import '../interceptors/authorized_interceptor.dart';

part 'profile_intro_api_service.chopper.dart';

@ChopperApi(baseUrl: "/user/")
abstract class ProfileIntroApiService extends ChopperService {
  static ProfileIntroApiService create() {
    final client = ChopperClient(
      baseUrl: ConfigReader.getApiBaseUrl(),
      services: [
        _$ProfileIntroApiService(),
      ],
      interceptors: [
        AuthorizedInterceptor(),
        HttpLoggingInterceptor(),
      ],
      converter: const JsonConverter(),
    );
    return _$ProfileIntroApiService(client);
  }

  @Get(path: "meta/profile/company/")
  Future<Response> getCompanies();

  @Get(path: "meta/profile/education/")
  Future<Response> getEducations();

  @Get(path: "meta/profile/experience/")
  Future<Response> getExperiences();

  @Get(path: "meta/profile/sector/")
  Future<Response> getSectors();

  @Post(path: 'auth/profile/')
  Future<Response> postUserProfile(@Body() Map<String, dynamic> body);

  // @Post(path: "profile/")
  // Future<Response> postUserProfile(@Body() Map<String, dynamic> body);
}
