import 'package:chopper/chopper.dart';
import 'package:worknetwork/api/interceptors/authorized_interceptor.dart';
import 'package:worknetwork/constants/app_constants.dart';

part 'masterclass_api_service.chopper.dart';

@ChopperApi(baseUrl: '/resources/masterclasses/')
abstract class MasterClassApiService extends ChopperService {
  static MasterClassApiService create() {
    final client = ChopperClient(
      baseUrl: AppConstants.apiBaseUrl,
      services: [
        _$MasterClassApiService(),
      ],
      interceptors: [AuthorizedInterceptor()],
    );
    return _$MasterClassApiService(client);
  }

  @Get(path: '')
  Future<Response> getVideosList({@Query() int page});

  @Get(path: '{id}/')
  Future<Response> getVideoItem({@Path() int id});
}
