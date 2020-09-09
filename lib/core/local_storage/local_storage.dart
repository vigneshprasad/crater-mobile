import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../../constants/app_hive_boxes.dart';
import '../../features/article/data/models/article_model.dart';
import '../../features/auth/data/models/user_model.dart';
import '../../features/chat/data/models/chat_message_model.dart';
import '../../features/chat/data/models/user_chat_model.dart';
import '../../features/chat_inbox/data/models/chat_user_model.dart';
import '../../features/community/data/models/comment_model.dart';
import '../../features/community/data/models/post_model.dart';
import '../../features/notification/data/models/notification_model.dart';
import '../../features/points/data/models/points_model.dart';
import '../../features/videos/data/models/video_model.dart';

abstract class LocalStorage {
  Future<void> initStorage();
  Future<void> deleteStorage();
}

class LocalStorageImpl implements LocalStorage {
  @override
  Future<void> deleteStorage() {
    // TODO: implement deleteStorage
    throw UnimplementedError();
  }

  @override
  Future<void> initStorage() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);

    // Register Adapters
    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(PostModelAdapter());
    Hive.registerAdapter(CommentModelAdapter());
    Hive.registerAdapter(FileDataModelAdapter());
    Hive.registerAdapter(ChatUserModelAdapter());
    Hive.registerAdapter(ChatMessageModelAdapter());
    Hive.registerAdapter(UserChatModelAdapter());
    Hive.registerAdapter(VideoModelAdapter());
    Hive.registerAdapter(PointsModelAdapter());
    Hive.registerAdapter(NotificationModelAdapter());
    Hive.registerAdapter(ArticleModelAdapter());

    // Open Boxes
    await Hive.openBox<UserModel>(AppHiveBoxes.userModelBox);
    await Hive.openBox<PostModel>(AppHiveBoxes.postsBox);
    await Hive.openBox<CommentModel>(AppHiveBoxes.commentsBox);
    await Hive.openBox<ChatUserModel>(AppHiveBoxes.chatUserBox);
    await Hive.openBox<ArticleModel>(AppHiveBoxes.articlesBox);
    await Hive.openBox<ChatMessageModel>(AppHiveBoxes.chatMessageBox);
    await Hive.openBox<UserChatModel>(AppHiveBoxes.userChatBox);
    await Hive.openBox<VideoModel>(AppHiveBoxes.videoBox);
    await Hive.openBox<PointsModel>(AppHiveBoxes.pointsBox);
    await Hive.openBox<NotificationModel>(AppHiveBoxes.notificationsBox);
  }
}
