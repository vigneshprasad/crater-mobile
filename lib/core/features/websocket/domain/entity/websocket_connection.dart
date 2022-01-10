import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketConnection extends Equatable {
  final WebSocketChannel channel;
  final StreamController streamController;

  const WebSocketConnection({
    required this.channel,
    required this.streamController,
  });

  @override
  List<Object> get props => [channel];
}
