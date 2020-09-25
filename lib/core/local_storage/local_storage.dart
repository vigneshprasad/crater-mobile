import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../../constants/app_hive_boxes.dart';
import '../../features/article/data/models/article_model.dart';
import '../../features/article/data/models/article_website_model.dart';
import '../../features/auth/data/models/user_model.dart';
import '../../features/auth/data/models/user_profile_model.dart';
import '../../features/auth/data/models/user_tag_model.dart';
import '../../features/chat/data/models/chat_message_model.dart';
import '../../features/chat/data/models/user_chat_model.dart';
import '../../features/chat_inbox/data/models/chat_user_model.dart';
import '../../features/community/data/models/comment_model.dart';
import '../../features/community/data/models/post_model.dart';
import '../../features/notification/data/models/notification_model.dart';
import '../../features/points/data/models/points_model.dart';
import '../../features/videos/data/models/video_model.dart';

abstract class LocalStorage {
  void registerAdapters();
  Future<void> initSdk();
  Future<void> initStorage();
  Future<void> deleteStorage();
}

class LocalStorageImpl implements LocalStorage {
  @override
  void registerAdapters() {
    // Register Adapters
    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(UserProfileModelAdapter());
    Hive.registerAdapter(UserTagModelAdapter());
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
    Hive.registerAdapter(ArticleWebsiteModelAdapter());
  }

  @override
  Future<void> initSdk() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
  }

  @override
  Future<void> initStorage() async {
    // Open Boxes
    await Hive.openBox<UserModel>(AppHiveBoxes.userModelBox);
    await Hive.openBox<UserProfileModel>(AppHiveBoxes.userProfileModelBox);
    await Hive.openBox<PostModel>(AppHiveBoxes.postsBox);
    await Hive.openBox<CommentModel>(AppHiveBoxes.commentsBox);
    await Hive.openBox<ChatUserModel>(AppHiveBoxes.chatUserBox);
    await Hive.openBox<ArticleModel>(AppHiveBoxes.articlesBox);
    await Hive.openBox<ArticleWebsiteModel>(AppHiveBoxes.articlesWebsiteBox);
    await Hive.openBox<ChatMessageModel>(AppHiveBoxes.chatMessageBox);
    await Hive.openBox<UserChatModel>(AppHiveBoxes.userChatBox);
    await Hive.openBox<VideoModel>(AppHiveBoxes.videoBox);
    await Hive.openBox<PointsModel>(AppHiveBoxes.pointsBox);
    await Hive.openBox<NotificationModel>(AppHiveBoxes.notificationsBox);
  }

  @override
  Future<void> deleteStorage() async {
    await Hive.box<UserModel>(AppHiveBoxes.userModelBox).clear();
    await Hive.box<UserProfileModel>(AppHiveBoxes.userProfileModelBox).clear();
    await Hive.box<PostModel>(AppHiveBoxes.postsBox).clear();
    await Hive.box<CommentModel>(AppHiveBoxes.commentsBox).clear();
    await Hive.box<ChatUserModel>(AppHiveBoxes.chatUserBox).clear();
    await Hive.box<ArticleModel>(AppHiveBoxes.articlesBox).clear();
    await Hive.box<ChatMessageModel>(AppHiveBoxes.chatMessageBox).clear();
    await Hive.box<UserChatModel>(AppHiveBoxes.userChatBox).clear();
    await Hive.box<VideoModel>(AppHiveBoxes.videoBox).clear();
    await Hive.box<PointsModel>(AppHiveBoxes.pointsBox).clear();
    await Hive.box<NotificationModel>(AppHiveBoxes.notificationsBox).clear();
  }
}
