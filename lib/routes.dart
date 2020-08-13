import 'package:flutter/material.dart';
import 'package:worknetwork/blocs/post/bloc/post_bloc.dart';
import 'package:worknetwork/ui/modals/create_post/create_post.dart';
import 'package:worknetwork/ui/screens/auth/auth_screen.dart';
import 'package:worknetwork/ui/screens/chat/chat_screen.dart';
import 'package:worknetwork/ui/screens/chat_search/chat_search_screen.dart';
import 'package:worknetwork/ui/screens/home/home_screen.dart';
import 'package:worknetwork/ui/screens/setup/setup_screen.dart';
import 'package:worknetwork/ui/screens/splash/splash_screen.dart';

class Routes {
  static const initial = "/";
  static const auth = "/auth";
  static const home = "/home";
  static const setup = "/setup";
  static const createPost = "/create-post";
  static const chatUser = "chat/user";
  static const chatSearch = "chat/search";

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
