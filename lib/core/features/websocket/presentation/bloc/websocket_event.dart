part of 'websocket_bloc.dart';

abstract class WebsocketEvent extends Equatable {
  const WebsocketEvent();

  @override
  List<Object> get props => [];
}

class WebSocketInitConnect extends WebsocketEvent {
  const WebSocketInitConnect();
}

class WebSocketInitIfAuth extends WebsocketEvent {
  const WebSocketInitIfAuth();
}
