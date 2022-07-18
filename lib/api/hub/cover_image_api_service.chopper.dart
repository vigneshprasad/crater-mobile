// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cover_image_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$CoverImageApiService extends CoverImageApiService {
  _$CoverImageApiService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = CoverImageApiService;

  @override
  Future<Response<dynamic>> generateImage(Map<String, dynamic> body) {
    final $url = '/test';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
