import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:worknetwork/models/websocket/requests/ws_requests.dart';

class InboxRepository {
  final WebSocketChannel channel;

  InboxRepository(this.channel);

  void getAllUsersRequest(WSAllUsersRequest request) {
    final data = jsonEncode(request.toJson());
    channel.sink.add(data);
  }
}
