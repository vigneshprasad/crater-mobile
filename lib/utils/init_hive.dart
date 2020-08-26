import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:worknetwork/constants/app_hive_boxes.dart';
import 'package:worknetwork/features/auth/data/models/user_model.dart';
import 'package:worknetwork/features/chat/data/models/chat_message_model.dart';
import 'package:worknetwork/features/chat/data/models/user_chat_model.dart';
import 'package:worknetwork/features/chat_inbox/data/models/chat_user_model.dart';
import 'package:worknetwork/models/comment/comment_model.dart';
import 'package:worknetwork/models/post/post_model.dart';

import '../models/chat/chat_model.dart';

Future<void> initHive() async {
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);

  // Register Adapters
  Hive.registerAdapter(PostModelAdapter());
  Hive.registerAdapter(CommentAdapter());
  Hive.registerAdapter(ChatMessageAdapter());
  Hive.registerAdapter(MessageNotificationAdapter());
  Hive.registerAdapter(UserChatMessagesDataAdapter());
  Hive.registerAdapter(ChatUserAdapter());

  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(ChatUserModelAdapter());
  Hive.registerAdapter(ChatMessageModelAdapter());
  Hive.registerAdapter(UserChatModelAdapter());

  // Open Boxes
  await Hive.openBox<MessageNotification>(AppHiveBoxes.notificationBox);
  await Hive.openBox<UserChatMessagesData>(AppHiveBoxes.chatMessagesDataBox);
  await Hive.openBox<ChatUser>(AppHiveBoxes.chatUsersBox);

  await Hive.openBox<UserModel>(AppHiveBoxes.userModelBox);
  await Hive.openBox<ChatUserModel>(AppHiveBoxes.chatUserBox);
  await Hive.openBox<ChatMessageModel>(AppHiveBoxes.chatMessageBox);
  await Hive.openBox<UserChatModel>(AppHiveBoxes.userChatBox);
}
