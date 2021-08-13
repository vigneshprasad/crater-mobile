import 'package:hive/hive.dart';

import '../../../chat_inbox/domain/entity/chat_user_entity.dart';
import 'chat_message_entity.dart';

class UserChat extends HiveObject {
  final String? recieverId;
  final ChatUser? receiverUser;
  final int? page;
  final int? pages;
  final List<ChatMessage>? messages;
  final int? unreadCount;

  UserChat({
    this.recieverId,
    this.receiverUser,
    this.page,
    this.pages,
    this.messages,
    this.unreadCount,
  });
}
