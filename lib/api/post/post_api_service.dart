import 'package:chopper/chopper.dart';
import 'package:http/http.dart' hide Response, Request;
import 'package:json_annotation/json_annotation.dart';
import 'package:worknetwork/api/interceptors/authorized_interceptor.dart';
import 'package:worknetwork/constants/app_constants.dart';
import 'package:worknetwork/models/post/post_model.dart';

part 'post_api_service.g.dart';
part 'post_api_service.chopper.dart';

@JsonSerializable()
class GetPostListResponse {
  int count;
  String next;
  String previous;

  @JsonKey(name: 'current_page')
  int currentPage;

  List<PostModel> results;

  GetPostListResponse({
    this.count,
    this.next,
    this.previous,
    this.currentPage,
    this.results,
  });

  factory GetPostListResponse.fromJson(Map<String, dynamic> json) =>
      _$GetPostListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetPostListResponseToJson(this);
}

@ChopperApi(baseUrl: '/community/posts/')
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

  @Get(path: '')
  Future<Response> getPostList();

  @Post(path: '')
  @Multipart()
  Future<Response> createPost(@Part() String message,
      @PartFile('files_formdata') List<MultipartFile> files);

  @Delete(path: '{id}/')
  Future<Response> deletePost(@Path() int id);
}
