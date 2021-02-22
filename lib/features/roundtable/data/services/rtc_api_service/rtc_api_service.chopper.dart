// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rtc_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$RtcApiService extends RtcApiService {
  _$RtcApiService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = RtcApiService;

  @override
  Future<Response<dynamic>> getRtcInfo(Map<String, dynamic> body) {
    final $url = '/integrations/agora/token/';
    final $body = body;
    final $request = Request('GET', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getRtcUserInfo(String uid) {
    final $url = '/integrations/agora/user/$uid';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
