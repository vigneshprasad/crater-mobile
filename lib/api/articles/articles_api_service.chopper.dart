// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'articles_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$ArticlesApiService extends ArticlesApiService {
  _$ArticlesApiService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = ArticlesApiService;

  @override
  Future<Response<dynamic>> getArticlesList() {
    final $url = '/resources/articles/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
