import 'package:dartz/dartz.dart';

import '../../../../error/failures.dart';
import '../entity/websocket_connection.dart';

abstract class WebSocketRepository {
  /// Connects To Backend Websocket via Remote and Set Stream Controller
  /// and Channel State
  /// @returns => [WebSocketConnection]
  /// @error => [Failure]
  Future<Either<Failure, WebSocketConnection>> connectToWebsocketBackend();

  /// Gets state websocket chanel and stream controller on device
  /// and Channel State
  /// @returns => [WebSocketConnection]
  /// /// @error => [Failure]
  Either<Failure, WebSocketConnection> getWebSocketConnectionState();

  /// Add message to WebSocket Sink
  /// and Channel State
  /// @returns => [WebSocketConnection]
  /// /// @error => [Failure]
  Future<Either<Failure, void>> addMessageToSink(Map<String, dynamic> message);

  /// Closes WebSocketConnection
  /// and Channel State
  /// @returns => [void]
  /// /// @error => [Failure]
  Future<Either<Failure, void>> closeWebSocketConnection();
}
