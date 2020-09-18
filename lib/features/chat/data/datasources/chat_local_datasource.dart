import 'package:hive/hive.dart';

import '../../../../constants/app_hive_boxes.dart';
import '../../../../core/error/exceptions.dart';
import '../../../chat_inbox/data/models/chat_user_model.dart';
import '../../../chat_inbox/domain/entity/chat_user_entity.dart';
import '../../domain/entity/chat_message_entity.dart';
import '../../domain/entity/user_chat_entity.dart';
import '../models/chat_message_model.dart';
import '../models/user_chat_model.dart';

abstract class ChatLocalDataSource {
  Future<ChatMessage> persistChatMessage(
      ChatMessage message, String userChatKey);
  Future<UserChat> persistUserChat(
    List<ChatMessage> messages,
    ChatUser receiverUser,
    int page,
    int pages,
    int unreadCount,
  );
  UserChat getUserChatFromCache(String receiverId);
}

class ChatLocalDataSourceImpl implements ChatLocalDataSource {
  final Box<UserChatModel> _userChatBox = Hive.box(AppHiveBoxes.userChatBox);
  final Box<ChatMessageModel> _chatMessagesBox =
      Hive.box(AppHiveBoxes.chatMessageBox);

  @override
  Future<ChatMessage> persistChatMessage(
      ChatMessage message, String userChatKey) async {
    List<ChatMessage> messages;

    try {
      final userChat = _userChatBox.get(userChatKey);
      await _chatMessagesBox.put(message.pk, message as ChatMessageModel);
      if (userChat != null) {
        userChat.messages.add(message as ChatMessageModel);
        messages = userChat.messages.toList();
      } else {
        messages = [message];
        await _updateUserChatHive(
          userChatKey,
          messages: messages,
        );
      }
      return message;
    } catch (error) {
      throw CacheException(error);
    }
  }

  @override
  Future<UserChat> persistUserChat(List<ChatMessage> messages,
      ChatUser receiverUser, int page, int pages, int unreadCount) async {
    try {
      await _persistMessagesToHive(messages);
      final updated = await _updateUserChatHive(
        receiverUser.pk,
        messages: messages,
        page: page,
        pages: pages,
        unreadCount: unreadCount,
        receiverUser: receiverUser,
      );
      return updated;
    } catch (error) {
      throw CacheException(error);
    }
  }

  // Private Methods
  Future<void> _persistMessagesToHive(List<ChatMessage> messages) async {
    final Map<String, ChatMessageModel> entries = messages.fold(
      {},
      (previousValue, element) => {
        element.pk.toString(): element as ChatMessageModel,
        ...previousValue,
      },
    );
    await _chatMessagesBox.putAll(entries);
  }

  Future<UserChat> _updateUserChatHive(
    String key, {
    List<ChatMessage> messages,
    ChatUser receiverUser,
    int page,
    int pages,
    int unreadCount,
  }) async {
    final persistedChat = _userChatBox.get(key);
    final messgesList = HiveList(
      _chatMessagesBox,
      objects: messages as List<ChatMessageModel>,
    );
    var updated = UserChatModel(
      receiverUser: receiverUser as ChatUserModel,
      page: page ?? 1,
      pages: pages ?? 1,
      unreadCount: unreadCount ?? 0,
      messages: messgesList ?? HiveList(_chatMessagesBox, objects: []),
    );

    if (persistedChat != null) {
      updated = persistedChat.copyWith(
        receiverUser: updated.receiverUser,
        page: updated.page,
        pages: updated.pages,
        unreadCount: updated.unreadCount,
        messages: messgesList,
      );
    }

    await _userChatBox.put(key, updated);
    return updated;
  }

  @override
  UserChat getUserChatFromCache(String receiverId) {
    final persisted = _userChatBox.get(receiverId);
    if (persisted == null) {
      throw CacheException();
    }
    return persisted;
  }
}
