// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'points_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$PointsApiService extends PointsApiService {
  _$PointsApiService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = PointsApiService;

  @override
  Future<Response<dynamic>> getSelfUserPoints() {
    final $url = '/points/my/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getPointsRules() {
    final $url = '/points/rules/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
