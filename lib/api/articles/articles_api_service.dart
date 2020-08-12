import 'package:chopper/chopper.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:worknetwork/api/interceptors/authorized_interceptor.dart';
import 'package:worknetwork/constants/app_constants.dart';
import 'package:worknetwork/models/article/article_model.dart';

part 'articles_api_service.g.dart';
part 'articles_api_service.chopper.dart';

@JsonSerializable()
class GetArticlesListResponse {
  final int count;

  @JsonKey(name: 'current_page')
  final int currentPage;
  final String next;
  final int pages;
  final String previous;
  final List<Article> results;

  GetArticlesListResponse({
    this.count,
    this.currentPage,
    this.next,
    this.pages,
    this.previous,
    this.results,
  });

  factory GetArticlesListResponse.fromJson(Map<String, dynamic> json) =>
      _$GetArticlesListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetArticlesListResponseToJson(this);
}

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
  Future<Response> getArticlesList();
}
