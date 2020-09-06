import 'package:chopper/chopper.dart';

import '../../constants/app_constants.dart';
import '../interceptors/authorized_interceptor.dart';

part 'articles_api_service.chopper.dart';

@ChopperApi(baseUrl: '/resources/articles/')
abstract class ArticlesApiService extends ChopperService {
  static ArticlesApiService create() {
    final client = ChopperClient(
      baseUrl: AppConstants.apiBaseUrl,
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
  Future<Response> getArticlesPage(
      @Query() int page, @Query("page_size") int pageSize);
}
