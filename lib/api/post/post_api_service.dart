import 'package:chopper/chopper.dart';
import 'package:http/http.dart' hide Response, Request;
import 'package:worknetwork/api/interceptors/authorized_interceptor.dart';
import 'package:worknetwork/constants/app_constants.dart';

part 'post_api_service.chopper.dart';

@ChopperApi(baseUrl: '/community/')
abstract class PostApiService extends ChopperService {
  static PostApiService create() {
    final client = ChopperClient(
      baseUrl: AppConstants.apiBaseUrl,
      services: [
        _$PostApiService(),
      ],
      interceptors: [
        AuthorizedInterceptor(),
      ],
    );
    return _$PostApiService(client);
  }

  @Get(path: 'posts/')
  Future<Response> getPostList(
    @Query("page_size") int pageSize,
    @Query() int page,
  );

  @Post(path: 'posts/')
  @Multipart()
  Future<Response> createPost(@Part() String message,
      @PartFile('files_formdata') List<MultipartFile> files);

  @Delete(path: '{id}/')
  Future<Response> deletePost(@Path() int id);

  @Post(path: 'likes/')
  Future<Response> createLike(@Body() Map<String, dynamic> body);

  @Delete(path: 'likes/{id}/')
  Future<Response> deleteLike(@Path() int id);
}
