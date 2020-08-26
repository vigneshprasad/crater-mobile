import 'package:auto_route/auto_route_annotations.dart';
import 'package:flutter/material.dart';

import 'blocs/post/bloc/post_bloc.dart';
import 'features/auth/presentation/screens/auth/auth_screen.dart';
import 'features/auth/presentation/screens/splash/splash_screen.dart';
import 'features/chat/presentation/screens/chat_screen.dart';
import 'ui/modals/create_post/create_post.dart';
import 'features/chat_inbox/presentation/screens/chat_search_screen.dart';
import 'ui/screens/home/home_screen.dart';
import 'ui/screens/setup/setup_screen.dart';

class Routes {
  static const initial = "/";
  static const auth = "/auth";
  static const home = "/home";
  static const setup = "/setup";
  static const createPost = "/create-post";
  static const chatUser = "/chat/user";
  static const chatSearch = "/chat/search";

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case initial:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case auth:
        return MaterialPageRoute(builder: (_) => AuthScreen());
      case home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case createPost:
        return MaterialPageRoute(
          builder: (_) => CreatePost(
            postBloc: args as PostBloc,
          ),
          fullscreenDialog: true,
        );
      case setup:
        return MaterialPageRoute(
            builder: (_) => SetupScreen(
                  initialTab: args as String,
                ));
      case chatUser:
        return MaterialPageRoute(
            builder: (_) => ChatScreen(
                  recieverId: args as String,
                ));
      case chatSearch:
        return MaterialPageRoute(
          builder: (_) => ChatSearchScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('No Route found'),
            ),
          ),
        );
    }
  }
}

@MaterialAutoRouter(
  generateNavigationHelperExtension: true,
  routes: <AutoRoute>[
    MaterialRoute(page: SplashScreen, initial: true),
    MaterialRoute(page: HomeScreen, path: "/home"),
    MaterialRoute(page: AuthScreen, path: "/auth"),
    MaterialRoute(page: SetupScreen, path: "/setup"),
    MaterialRoute(
        page: CreatePost, path: "/create-post", fullscreenDialog: true),
    MaterialRoute(page: ChatScreen, path: "/chat/user"),
    MaterialRoute(page: ChatSearchScreen, path: "/chat/search")
  ],
)
class $Router {}
