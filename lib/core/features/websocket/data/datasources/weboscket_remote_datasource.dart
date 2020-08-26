import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../../../constants/app_constants.dart';
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
      final channel = IOWebSocketChannel.connect(
          "${AppConstants.websocketBaseUrl}/$token/");
      return channel;
    } catch (error) {
      throw WebsocketServerException(error);
    }
  }
}
