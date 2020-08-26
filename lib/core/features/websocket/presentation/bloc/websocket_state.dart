part of 'websocket_bloc.dart';

abstract class WebsocketState extends Equatable {
  const WebsocketState();

  @override
  List<Object> get props => [];
}

class WebsocketInitial extends WebsocketState {}

class WebSocketConnected extends WebsocketState {
  final WebSocketChannel channel;
  final StreamController controller;

  const WebSocketConnected({
    @required this.channel,
    @required this.controller,
  });

  @override
  List<Object> get props => [channel, controller];
}

class WebSocketConnectLoading extends WebsocketState {
  const WebSocketConnectLoading();
}

class WebSocketDisconnected extends WebsocketState {
  final dynamic error;

  const WebSocketDisconnected({
    this.error,
  });

  @override
  List<Object> get props => [error];
}
