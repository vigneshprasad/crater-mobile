import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../../config_reader/config_reader.dart';
import '../../../../error/exceptions.dart';

abstract class WebSocketRemoteDataSource {
  /// Creates New Websocket Connection to Backend
  /// @return => [WebSocketChannel]
  /// @error [WebsocketServerException] on Failure
  Future<WebSocketChannel> connectToWebsocketBackend(String token);
}

class WebSocketRemoteDataSourceImpl implements WebSocketRemoteDataSource {
  @override
  Future<WebSocketChannel> connectToWebsocketBackend(String token) async {
    try {
      final baseUrl = ConfigReader.getWebSocketBaseUrl();
      final channel = IOWebSocketChannel.connect("$baseUrl/$token/");
      return channel;
    } catch (error) {
      throw WebsocketServerException(error);
    }
  }
}
