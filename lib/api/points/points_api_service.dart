import 'package:chopper/chopper.dart';

import '../../core/config_reader/config_reader.dart';
import '../interceptors/authorized_interceptor.dart';

part 'points_api_service.chopper.dart';

@ChopperApi(baseUrl: '/points/')
abstract class PointsApiService extends ChopperService {
  static PointsApiService create() {
    final client = ChopperClient(
      baseUrl: ConfigReader.getApiBaseUrl(),
      services: [
        _$PointsApiService(),
      ],
      interceptors: [
        AuthorizedInterceptor(),
      ],
    );
    return _$PointsApiService(client);
  }

  @Get(path: 'my/')
  Future<Response> getSelfUserPoints();
}
