import 'package:chopper/chopper.dart';
import 'package:http/http.dart' hide Response, Request;
import 'package:worknetwork/api/interceptors/authorized_interceptor.dart';
import 'package:worknetwork/constants/app_constants.dart';

part 'points_api_service.chopper.dart';

@ChopperApi(baseUrl: '/points/')
abstract class PointsApiService extends ChopperService {
  static PointsApiService create() {
    final client = ChopperClient(
      baseUrl: AppConstants.apiBaseUrl,
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
