import 'package:chopper/chopper.dart';

import '../../core/config_reader/config_reader.dart';
import '../interceptors/authorized_interceptor.dart';

part 'tags_api_service.chopper.dart';

@ChopperApi(baseUrl: "/tags/")
abstract class TagsApiService extends ChopperService {
  static TagsApiService create() {
    final client = ChopperClient(
      baseUrl: ConfigReader.getApiBaseUrl(),
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

  @Get(path: "user/")
  Future<Response> getUserTags();

  @Get(path: "websites/")
  Future<Response> getArticleWebsites();
}
