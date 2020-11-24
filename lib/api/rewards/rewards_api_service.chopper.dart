// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rewards_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$RewardsApiService extends RewardsApiService {
  _$RewardsApiService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = RewardsApiService;

  @override
  Future<Response<dynamic>> getPackagesList() {
    final $url = '/rewards/package/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getPackage(int id) {
    final $url = '/rewards/package/$id/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> postPackageRequest(Map<String, dynamic> body) {
    final $url = '/rewards/package/request';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
