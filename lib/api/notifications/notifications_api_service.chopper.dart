// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$NotificationApiService extends NotificationApiService {
  _$NotificationApiService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = NotificationApiService;

  @override
  Future<Response<dynamic>> getMyNotificationPage(int pageSize, int page) {
    final $url = '/notifications/my/';
    final $params = <String, dynamic>{'pageSize': pageSize, 'page': page};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }
}
