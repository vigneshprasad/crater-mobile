part of 'websocket_bloc.dart';

abstract class WebsocketState extends Equatable {
  final dynamic error;
  final WebSocketChannel channel;
  final String token;
  const WebsocketState({
    this.token,
    this.channel,
    this.error,
  });
}

class WebsocketInitial extends WebsocketState {
  @override
  List<Object> get props => [];
}

class WebSocketConnected extends WebsocketState {
  const WebSocketConnected({
    WebSocketChannel channel,
  }) : super(channel: channel);

  @override
  List<Object> get props => [channel];
}

class WebSocketConnectFailed extends WebsocketState {
  const WebSocketConnectFailed({
    dynamic error,
  }) : super(error: error);

  @override
  List<Object> get props => [error];
}
