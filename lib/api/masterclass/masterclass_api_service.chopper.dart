// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'masterclass_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$MasterClassApiService extends MasterClassApiService {
  _$MasterClassApiService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = MasterClassApiService;

  @override
  Future<Response<dynamic>> getVideosList({int? page}) {
    final $url = '/resources/masterclasses/';
    final $params = <String, dynamic>{'page': page};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getVideoItem({required int id}) {
    final $url = '/resources/masterclasses/$id/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
