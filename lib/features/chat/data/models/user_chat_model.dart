import 'package:hive/hive.dart';

import '../../../../constants/app_hive_boxes.dart';
import '../../../chat_inbox/data/models/chat_user_model.dart';
import '../../domain/entity/user_chat_entity.dart';
import 'chat_message_model.dart';

part 'user_chat_model.g.dart';

// ignore_for_file: annotate_overrides
// ignore_for_file: overridden_fields

@HiveType(typeId: AppHiveTypeIds.userChat)
class UserChatModel extends UserChat {
  @HiveField(0)
  final String? recieverId;

  @HiveField(1)
  final ChatUserModel? receiverUser;

  @HiveField(2)
  final int? page;

  @HiveField(3)
  final int? pages;

  @HiveField(4)
  final HiveList<ChatMessageModel>? messages;

  @HiveField(5)
  final int? unreadCount;

  UserChatModel({
    this.recieverId,
    this.receiverUser,
    this.page,
    this.pages,
    this.messages,
    this.unreadCount,
  }) : super(
          recieverId: recieverId,
          receiverUser: receiverUser,
          page: page,
          pages: pages,
          messages: messages,
          unreadCount: unreadCount,
        );

  UserChatModel copyWith({
    String? recieverId,
    ChatUserModel? receiverUser,
    int? page,
    int? pages,
    HiveList<ChatMessageModel>? messages,
    int? unreadCount,
  }) {
    return UserChatModel(
      recieverId: recieverId ?? this.recieverId,
      receiverUser: receiverUser ?? this.receiverUser,
      page: page ?? this.page,
      pages: pages ?? this.pages,
      messages: messages ?? this.messages,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }
}
