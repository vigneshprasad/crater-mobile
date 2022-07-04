part of 'websocket_bloc.dart';

abstract class WebsocketEvent extends Equatable {
  const WebsocketEvent();

  @override
  List<Object> get props => [];
}

class WebSocketInitConnect extends WebsocketEvent {
  final String groupId;

  const WebSocketInitConnect({
    required this.groupId,
  });
}

class WebSocketInitIfAuth extends WebsocketEvent {
  const WebSocketInitIfAuth();
}

class WebSocketCloseStarted extends WebsocketEvent {
  const WebSocketCloseStarted();
}
