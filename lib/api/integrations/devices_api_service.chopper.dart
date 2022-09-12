// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'devices_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$DevicesApiService extends DevicesApiService {
  _$DevicesApiService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = DevicesApiService;

  @override
  Future<Response<dynamic>> registerDevice(Map<String, dynamic> body) {
    final $url = '/integrations/onesignal/devices/register/';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
