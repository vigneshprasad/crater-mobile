// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$ProfileApiService extends ProfileApiService {
  _$ProfileApiService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = ProfileApiService;

  @override
  Future<Response<dynamic>> retrieveProfiles(
      String tags, String search, int page, int pageSize) {
    final $url = '/user/auth/network/';
    final $params = <String, dynamic>{
      'new_tag': tags,
      'search': search,
      'page': page,
      'page_size': pageSize
    };
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> retrieveUserConnections(
      String tags, String search, int page, int pageSize, String profileId) {
    final $url = '/user/auth/network/{userId}/';
    final $params = <String, dynamic>{
      'tags': tags,
      'search': search,
      'page': page,
      'page_size': pageSize
    };
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> retrieveAllProfiles(
      String search, int page, int pageSize) {
    final $url = '/user/auth/network/';
    final $params = <String, dynamic>{
      'search': search,
      'page': page,
      'page_size': pageSize
    };
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> retrieveProfile(String profileId) {
    final $url = '/user/auth/network/$profileId/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getUserConnections(String profileId) {
    final $url = '/user/auth/profile/$profileId/connections/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
