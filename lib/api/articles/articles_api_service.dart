import 'package:chopper/chopper.dart';

import '../../core/config_reader/config_reader.dart';
import '../interceptors/authorized_interceptor.dart';

part 'articles_api_service.chopper.dart';

@ChopperApi(baseUrl: '/resources/articles/')
abstract class ArticlesApiService extends ChopperService {
  static ArticlesApiService create() {
    final client = ChopperClient(
      baseUrl: ConfigReader.getApiBaseUrl(),
      services: [
        _$ArticlesApiService(),
      ],
      interceptors: [
        AuthorizedInterceptor(),
      ],
    );
    return _$ArticlesApiService(client);
  }

  @Get(path: '')
  Future<Response> getArticlesPage(@Query() int page,
      @Query("page_size") int pageSize, @Query("website_tags") int websiteTags);
}
