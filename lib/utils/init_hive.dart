import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../constants/app_hive_boxes.dart';
import '../features/auth/data/models/user_model.dart';
import '../features/chat/data/models/chat_message_model.dart';
import '../features/chat/data/models/user_chat_model.dart';
import '../features/chat_inbox/data/models/chat_user_model.dart';
import '../features/points/data/models/points_model.dart';
import '../features/videos/data/models/video_model.dart';
import '../models/comment/comment_model.dart';
import '../models/post/post_model.dart';

Future<void> initHive() async {
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);

  // Register Adapters
  Hive.registerAdapter(PostModelAdapter());
  Hive.registerAdapter(CommentAdapter());

  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(ChatUserModelAdapter());
  Hive.registerAdapter(ChatMessageModelAdapter());
  Hive.registerAdapter(UserChatModelAdapter());
  Hive.registerAdapter(VideoModelAdapter());
  Hive.registerAdapter(PointsModelAdapter());

  // Open Boxes

  await Hive.openBox<UserModel>(AppHiveBoxes.userModelBox);
  await Hive.openBox<ChatUserModel>(AppHiveBoxes.chatUserBox);
  await Hive.openBox<ChatMessageModel>(AppHiveBoxes.chatMessageBox);
  await Hive.openBox<UserChatModel>(AppHiveBoxes.userChatBox);
  await Hive.openBox<VideoModel>(AppHiveBoxes.videoBox);
  await Hive.openBox<PointsModel>(AppHiveBoxes.pointsBox);
}
