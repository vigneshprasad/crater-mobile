// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connection_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$ConnectionApiService extends ConnectionApiService {
  _$ConnectionApiService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = ConnectionApiService;

  @override
  Future<Response<dynamic>> getCreator(int id) {
    final $url = '/crater/creator/${id}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getCreators(Map<String, dynamic> body) {
    final $url = '/crater/creator/';
    final $params = body;
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getCommunityMembers(Map<String, dynamic> body) {
    final $url = '/crater/community/members/';
    final $params = body;
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> followCreator(Map<String, dynamic> body) {
    final $url = '/crater/followers/notify/';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
