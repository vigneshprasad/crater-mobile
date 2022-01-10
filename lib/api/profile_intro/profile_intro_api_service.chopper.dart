// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_intro_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$ProfileIntroApiService extends ProfileIntroApiService {
  _$ProfileIntroApiService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = ProfileIntroApiService;

  @override
  Future<Response<dynamic>> getCompanies() {
    final $url = '/user/meta/profile/company/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getEducations() {
    final $url = '/user/meta/profile/education/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getExperiences() {
    final $url = '/user/meta/profile/experience/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getSectors() {
    final $url = '/user/meta/profile/sector/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postUserProfile(Map<String, dynamic> body) {
    final $url = '/user/auth/profile/';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
