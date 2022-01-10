// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$PostApiService extends PostApiService {
  _$PostApiService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = PostApiService;

  @override
  Future<Response<dynamic>> getPostList(int pageSize, int page) {
    final $url = '/community/posts/';
    final $params = <String, dynamic>{'page_size': pageSize, 'page': page};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getPost(int id) {
    final $url = '/community/posts/$id/';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> createPost(
      String message, List<MultipartFile> files) {
    final $url = '/community/posts/';
    final $parts = <PartValue>[
      PartValue<String>('message', message),
      PartValueFile<List<MultipartFile>>('files_formdata', files)
    ];
    final $request =
        Request('POST', $url, client.baseUrl, parts: $parts, multipart: true);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> deletePost(int id) {
    final $url = '/community/posts/$id/';
    final $request = Request('DELETE', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> createLike(Map<String, dynamic> body) {
    final $url = '/community/likes/';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> deleteLike(int id) {
    final $url = '/community/likes/$id/';
    final $request = Request('DELETE', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getCommentsPage(
      int id, int pageSize, int page, int offset) {
    final $url = '/community/comments/$id/post/';
    final $params = <String, dynamic>{
      'page_size': pageSize,
      'page': page,
      'offset': offset
    };
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> createCommentForPost(Map<String, dynamic> body) {
    final $url = '/community/comments/';
    final $body = body;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
