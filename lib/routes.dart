import 'package:auto_route/auto_route_annotations.dart';

import 'core/widgets/screens/home_screen.dart';
import 'features/auth/presentation/screens/auth/auth_screen.dart';
import 'features/auth/presentation/screens/splash/splash_screen.dart';
import 'features/chat/presentation/screens/chat_screen.dart';
import 'features/chat_inbox/presentation/screens/chat_search_screen.dart';
import 'features/community/presentation/screens/post_screen.dart';
import 'features/notification/presentation/screens/notifications_screen.dart';
import 'features/videos/presentation/screens/video_player_screen.dart';
import 'ui/screens/setup/setup_screen.dart';

@MaterialAutoRouter(
  generateNavigationHelperExtension: true,
  routes: <AutoRoute>[
    MaterialRoute(page: SplashScreen, initial: true),
    MaterialRoute(page: HomeScreen, path: "/home"),
    MaterialRoute(page: AuthScreen, path: "/auth"),
    MaterialRoute(page: SetupScreen, path: "/setup"),
    // MaterialRoute(
    //     page: CreatePost, path: "/create-post", fullscreenDialog: true),
    MaterialRoute(page: ChatScreen, path: "/chat/user"),
    MaterialRoute(page: ChatSearchScreen, path: "/chat/search"),
    MaterialRoute(page: VideoPlayerScreen, path: "/video-player"),
    MaterialRoute(page: NotificationsScreen, path: "/notifications"),
    MaterialRoute(page: PostScreen, path: "/post")
  ],
)
class $Router {}
