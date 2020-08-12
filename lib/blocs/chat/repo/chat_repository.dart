import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:worknetwork/models/websocket/requests/ws_requests.dart';

class ChatRepository {
  final WebSocketChannel channel;

  ChatRepository(this.channel);

  void setChatWithUser(final String recieverId) {
    final request = WSSetChatUserRequest(
      message: SetChatRequestOptions(
        page: 1,
        user: recieverId,
      ),
    );
    channel.sink.add(jsonEncode(request.toJson()));
  }

  void sendMessageToUser(final String message) {
    final request = WSSendMessageToUserRequest(message: message);
    channel.sink.add(jsonEncode(request.toJson()));
  }

  void senduserIsTyping() {
    channel.sink.add(jsonEncode({"type": "user_is_typing"}));
  }
}
