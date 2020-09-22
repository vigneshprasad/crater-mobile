// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tags_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$TagsApiService extends TagsApiService {
  _$TagsApiService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = TagsApiService;

  @override
  Future<Response<dynamic>> getUserObjectives() {
    final $url = '/tags/objectives/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getUserTags() {
    final $url = '/tags/user/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getArticleWebsites() {
    final $url = '/tags/websites/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
