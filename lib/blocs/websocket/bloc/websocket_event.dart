part of 'websocket_bloc.dart';

abstract class WebsocketEvent extends Equatable {
  const WebsocketEvent();
}

class ConnectWebsocket extends WebsocketEvent {
  @override
  List<Object> get props => [];
}
