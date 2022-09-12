// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_meta_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$ProfileMetaApiService extends ProfileMetaApiService {
  _$ProfileMetaApiService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = ProfileMetaApiService;

  @override
  Future<Response<dynamic>> getProfileExtraFormMeta(int id) {
    final $url = '/user/meta/profile/${id}/tag_extra_info/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
