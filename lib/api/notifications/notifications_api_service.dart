import 'package:chopper/chopper.dart';
import 'package:worknetwork/api/interceptors/authorized_interceptor.dart';
import 'package:worknetwork/constants/app_constants.dart';

part 'notifications_api_service.chopper.dart';

@ChopperApi(baseUrl: "/notifications/")
abstract class NotificationApiService extends ChopperService {
  static NotificationApiService create() {
    final client = ChopperClient(
      baseUrl: AppConstants.apiBaseUrl,
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
