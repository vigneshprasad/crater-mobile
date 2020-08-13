import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:worknetwork/constants/app_hive_boxes.dart';
import 'package:worknetwork/models/chat/chat_model.dart';
import 'package:worknetwork/models/websocket/requests/ws_requests.dart';

class ChatRepository {
  final WebSocketChannel channel;
  Box<UserChatBox> userChatBox;

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

  void searchAllUsers(AllUserRequestOptions options) {
    final request = jsonEncode(WSAllUsersRequest(message: options).toJson());
    channel.sink.add(request);
  }

  Future<UserChatBox> getInitialState(String recieverId) async {
    userChatBox ??= Hive.box<UserChatBox>(AppHiveBoxes.userChatbox);
    final chatData = userChatBox.get("recieverId");
    return chatData;
  }

  Future<UserChatBox> updateChatBox(
    ChatUser recieverUser,
    List<ChatMessage> messages,
    int page,
    int pages,
  ) async {
    userChatBox ??= Hive.box<UserChatBox>(AppHiveBoxes.userChatbox);
    final data = UserChatBox(
      messages: messages,
      recieverUser: recieverUser,
      page: page,
      pages: pages,
    );
    await userChatBox.put(recieverUser.pk, data);
    return userChatBox.get(recieverUser.pk);
  }

  Future<UserChatBox> addMessageToBox(
      ChatMessage message, String recieverId) async {
    userChatBox ??= Hive.box<UserChatBox>(AppHiveBoxes.userChatbox);
    var data = userChatBox.get(recieverId);
    final messages = data.messages;
    messages.insert(0, message);
    data = data.copyWith(messages: messages);
    await userChatBox.put(recieverId, data);
    return userChatBox.get(recieverId);
  }
}
