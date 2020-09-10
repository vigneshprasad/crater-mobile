import 'package:chopper/chopper.dart';
import 'package:worknetwork/api/interceptors/authorized_interceptor.dart';
import 'package:worknetwork/constants/app_constants.dart';

part 'tags_api_service.chopper.dart';

@ChopperApi(baseUrl: "/tags/")
abstract class TagsApiService extends ChopperService {
  static TagsApiService create() {
    final client = ChopperClient(
      baseUrl: AppConstants.apiBaseUrl,
      services: [
        _$TagsApiService(),
      ],
      interceptors: [
        AuthorizedInterceptor(),
      ],
    );
    return _$TagsApiService(client);
  }

  @Get(path: "objectives/")
  Future<Response> getUserObjectives();
}
