import 'package:chopper/chopper.dart';

import '../../core/config_reader/config_reader.dart';
import '../interceptors/authorized_interceptor.dart';

part 'masterclass_api_service.chopper.dart';

@ChopperApi(baseUrl: '/resources/masterclasses/')
abstract class MasterClassApiService extends ChopperService {
  static MasterClassApiService create() {
    final client = ChopperClient(
      baseUrl: ConfigReader.getApiBaseUrl(),
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
