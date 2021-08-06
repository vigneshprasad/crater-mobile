// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dyte_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$DyteApiService extends DyteApiService {
  _$DyteApiService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = DyteApiService;

  @override
  Future<Response<dynamic>> getDyteCredsRequest(int meetingId) {
    final $url = '/integrations/dyte/participants/$meetingId/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
