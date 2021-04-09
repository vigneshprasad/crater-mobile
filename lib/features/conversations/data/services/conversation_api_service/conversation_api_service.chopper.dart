// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$ConversationApiService extends ConversationApiService {
  _$ConversationApiService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = ConversationApiService;

  @override
  Future<Response<dynamic>> getAllTopics(int parent) {
    final $url = '/groups/topic/';
    final $params = <String, dynamic>{'parent': parent};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getAllRootTopicsForConversations() {
    final $url = '/groups/topic/for_groups/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getConversations(Map<String, dynamic> body) {
    final $url = '/groups/groups/';
    final $body = body;
    final $request = Request('GET', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getMyConversations(Map<String, dynamic> body) {
    final $url = '/groups/groups/my/';
    final $body = body;
    final $request = Request('GET', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> retrieveConversation(int id) {
    final $url = '/groups/groups/$id/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postConversationOptin(Map<String, dynamic> body) {
    final $url = '/groups/optin/';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getAllMyOptins() {
    final $url = '/groups/optin/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postConversationRequest(Map<String, dynamic> body) {
    final $url = '/groups/requests/';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
