import 'package:hive/hive.dart';

import '../../../chat/domain/entity/chat_message_entity.dart';

class ChatUser extends HiveObject {
  final String pk;

  final String name;

  final String photo;

  final int unreadCount;

  final bool isStarred;

  final DateTime lastSeen;

  final ChatMessage latestMessage;

  ChatUser({
    this.pk,
    this.name,
    this.photo,
    this.unreadCount,
    this.isStarred,
    this.lastSeen,
    this.latestMessage,
  });
}
