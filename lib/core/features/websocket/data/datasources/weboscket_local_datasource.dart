import 'dart:async';
import 'package:web_socket_channel/status.dart' as status;

import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:worknetwork/core/error/exceptions.dart';

abstract class WebSocketLocalDataSource {
  /// Local Websocket channel to Backendx
  WebSocketChannel channel;

  /// Stream controller for websocket channel
  StreamController streamcontroller;

  /// Close Websocket Channel Sonk
  /// @error => [WebSocketCloseException]
  Future<void> closeConnection();
}

class WebsocketLocalDataSourceImpl implements WebSocketLocalDataSource {
  @override
  WebSocketChannel channel;

  @override
  StreamController streamcontroller = StreamController.broadcast();

  @override
  Future<void> closeConnection() async {
    try {
      await channel.sink.close(status.normalClosure);
    } catch (error) {
      throw WebSocketCloseException();
    }
  }
}
