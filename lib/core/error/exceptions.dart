class ServerException implements Exception {
  final dynamic message;
  ServerException([this.message]);
}

class CacheException implements Exception {
  final dynamic message;
  CacheException([this.message]);
}

class WebsocketServerException implements Exception {
  final dynamic message;
  WebsocketServerException([this.message]);
}

class WebSocketCloseException implements Exception {
  final dynamic message;
  WebSocketCloseException([this.message]);
}

class WebsocketLocalException implements Exception {
  final dynamic message;
  WebsocketLocalException([this.message]);
}
