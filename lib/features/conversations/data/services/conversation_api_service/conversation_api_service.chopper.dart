// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$ConversationApiService extends ConversationApiService {
  _$ConversationApiService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = ConversationApiService;

  @override
  Future<Response<dynamic>> getConversationsByDate(
      DateTime start, DateTime end) {
    final $url = '/groups/conversation/calendar/';
    final $params = <String, dynamic>{'start': start, 'end': end};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getMyConversationsByDate(
      DateTime start, DateTime end) {
    final $url = '/groups/conversation/calendar/my/';
    final $params = <String, dynamic>{'start': start, 'end': end};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getAllTopics(int? parent) {
    final $url = '/groups/topic/';
    final $params = <String, dynamic>{'parent': parent};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getAllAMATopics() {
    final $url = '/groups/topic/ama/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getAllArticleTopics() {
    final $url = '/groups/topic/articles/';
    final $request = Request('GET', $url, client.baseUrl);
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
  Future<Response<dynamic>> postInstantConversation(Map<String, dynamic> body) {
    final $url = '/groups/groups/instant/';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getInstantConversationTimeSlots() {
    final $url = '/groups/groups/instant_time_slots/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getChatReactions() {
    final $url = '/groups/conversations/chatreactions/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getChatReactionDetail(String id) {
    final $url = '/groups/conversations/chatreactions/$id';
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
  Future<Response<dynamic>> getOptinsByDate() {
    final $url = '/groups/optin/by_date/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getWebinarRSVP(int id) {
    final $url = '/groups/requests/$id';
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

  @override
  Future<Response<dynamic>> postTopicSuggestionRequest(
      Map<String, dynamic> body) {
    final $url = '/groups/topic/suggest/';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getWebinarCategories() {
    final $url = '/groups/conversations/categories';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getAllClubs() {
    final $url = '/groups/public/conversations/webinars/all';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getLiveClubs(String? host) {
    final $url = '/groups/public/conversations/webinars/live';
    final $params = <String, dynamic>{'host': host};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getUpcomingClubs(
      String? host, int? page, int? pageSize) {
    final $url = '/groups/public/conversations/webinars/upcoming';
    final $params = <String, dynamic>{
      'host': host,
      'page': page,
      'page_size': pageSize
    };
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getPastClubs(
      String? host, int? page, int? pageSize, int? categoryId) {
    final $url = '/groups/public/conversations/webinars/past';
    final $params = <String, dynamic>{
      'host': host,
      'page': page,
      'page_size': pageSize,
      'categories': categoryId
    };
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getFeaturedClubs(
      String? host, int? page, int? pageSize) {
    final $url = '/groups/public/conversations/webinars/featured';
    final $params = <String, dynamic>{
      'host': host,
      'page': page,
      'page_size': pageSize
    };
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> retrieveWebinar(int id) {
    final $url = '/groups/conversations/webinars/$id/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> retrieveCreators(int? page, int? pageSize) {
    final $url = '/groups/conversations/webinars/creators/';
    final $params = <String, dynamic>{'page': page, 'page_size': pageSize};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getSeries(int? page, int? pageSize) {
    final $url = '/groups/public/conversations/series/';
    final $params = <String, dynamic>{'page': page, 'page_size': pageSize};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getSeriesDetails(int id) {
    final $url = '/groups/public/conversations/series/$id';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postSeriesRequest(Map<String, dynamic> body) {
    final $url = '/groups/conversations/series/requests/';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
