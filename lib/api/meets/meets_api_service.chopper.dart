// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meets_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$MeetsApiService extends MeetsApiService {
  _$MeetsApiService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = MeetsApiService;

  @override
  Future<Response<dynamic>> getMeetingsConfig() {
    final $url = '/resources/meetings/config/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getMeetingPreferences() {
    final $url = '/resources/meetings/preferences/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postMeetingPreferences(Map<String, dynamic> body) {
    final $url = '/resources/meeting-preferences/';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> patchMeetingPreferences(
      int id, Map<String, dynamic> body) {
    final $url = '/resources/meeting-preferences/$id/';
    final $body = body;
    final $request = Request('PATCH', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getMeetings() {
    final $url = '/resources/meetings/meeting/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getMeetingObjectives() {
    final $url = '/resources/meetings/objectives/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getMeetingInterests() {
    final $url = '/resources/meetings/interests/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
