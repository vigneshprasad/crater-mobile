import 'package:chopper/chopper.dart';

import '../../core/config_reader/config_reader.dart';
import '../interceptors/authorized_interceptor.dart';

part 'notifications_api_service.chopper.dart';

@ChopperApi(baseUrl: "/notifications/")
abstract class NotificationApiService extends ChopperService {
  static NotificationApiService create() {
    final client = ChopperClient(
      baseUrl: ConfigReader.getApiBaseUrl(),
      services: [
        _$NotificationApiService(),
      ],
      interceptors: [
        AuthorizedInterceptor(),
      ],
    );
    return _$NotificationApiService(client);
  }

  @Get(path: 'my/')
  Future<Response> getMyNotificationPage(
      @Query() int pageSize, @Query() int page);
}
