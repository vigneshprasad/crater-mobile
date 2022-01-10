// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'articles_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$ArticlesApiService extends ArticlesApiService {
  _$ArticlesApiService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = ArticlesApiService;

  @override
  Future<Response<dynamic>> getArticlesPage(
      int page, int pageSize, int websiteTags) {
    final $url = '/resources/articles/';
    final $params = <String, dynamic>{
      'page': page,
      'page_size': pageSize,
      'website_tags': websiteTags
    };
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }
}
