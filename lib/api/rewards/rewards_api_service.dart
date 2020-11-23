import 'package:chopper/chopper.dart';

import '../../core/config_reader/config_reader.dart';
import '../interceptors/authorized_interceptor.dart';

part 'rewards_api_service.chopper.dart';

@ChopperApi(baseUrl: '/rewards/')
abstract class RewardsApiService extends ChopperService {
  static RewardsApiService create() {
    final client = ChopperClient(
      baseUrl: ConfigReader.getApiBaseUrl(),
      services: [_$RewardsApiService()],
      interceptors: [AuthorizedInterceptor()],
      converter: const JsonConverter(),
    );
    return _$RewardsApiService(client);
  }

  @Get(path: 'package/')
  Future<Response> getPackagesList();

  @Get(path: 'package/{id}/')
  Future<Response> getPackage(@Path() int id);

  @Post(path: 'package/request')
  Future<Response> postPackageRequest(@Body() Map<String, dynamic> body);
}
