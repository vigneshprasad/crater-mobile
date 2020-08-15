import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:worknetwork/constants/app_hive_boxes.dart';
import 'package:worknetwork/models/chat/chat_model.dart';
import 'package:worknetwork/models/websocket/requests/ws_requests.dart';

class InboxRepository {
  final WebSocketChannel channel;

  InboxRepository(this.channel);

  void getAllUsersRequest(WSAllUsersRequest request) {
    final data = jsonEncode(request.toJson());
    channel.sink.add(data);
  }

  Future<List<ChatUser>> persistChatUsers(List<ChatUser> users) async {
    final box = Hive.box<ChatUser>(AppHiveBoxes.chatUsersBox);
    for (final user in users) {
      final cached = box.get(user.pk);
      final updated = cached != null
          ? cached.copyWith(
              isStarred: user.isStarred,
              lastSeen: user.lastSeen,
              name: user.name,
              photo: user.photo,
              latestMessage: user.latestMessage,
            )
          : user;
      await box.put(user.pk, updated);
    }

    return box.values.toList();
  }

  Future<List<ChatUser>> updateChatUserData(
      MessageNotification notification) async {
    final box = Hive.box<ChatUser>(AppHiveBoxes.chatUsersBox);
    final user = box.get(notification.pk);
    if (user != null) {
      final updated = user.copyWith(
        unreadCount: notification.unreadCount,
      );
      await box.put(notification.pk, updated);
    }
    return box.values.toList();
  }
}
