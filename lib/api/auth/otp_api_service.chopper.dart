// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$OtpApiService extends OtpApiService {
  _$OtpApiService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = OtpApiService;

  @override
  Future<Response<dynamic>> verifyOtp(Map<String, dynamic> body) {
    final $url = '/crater/auth/verify/';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> sendOtp(Map<String, dynamic> body) {
    final $url = '/crater/auth/otp/';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
