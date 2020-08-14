import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:worknetwork/constants/app_hive_boxes.dart';
import 'package:worknetwork/models/comment/comment_model.dart';
import 'package:worknetwork/models/post/post_model.dart';
import 'package:worknetwork/models/user/user_model.dart';

import '../models/chat/chat_model.dart';

Future<void> initHive() async {
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);

  // Register Adapters
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(PostModelAdapter());
  Hive.registerAdapter(CommentAdapter());
  Hive.registerAdapter(ChatMessageAdapter());
  Hive.registerAdapter(MessageNotificationAdapter());
  Hive.registerAdapter(UserChatBoxAdapter());
  Hive.registerAdapter(ChatUserAdapter());

  // Open Boxes
  await Hive.openBox<MessageNotification>(AppHiveBoxes.notificationBox);
  await Hive.openBox<UserChatBox>(AppHiveBoxes.userChatbox);
  await Hive.openBox<ChatMessageAdapter>(AppHiveBoxes.chatMessagesBox);
}
