// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'blocs/post/bloc/post_bloc.dart';
import 'features/auth/presentation/screens/auth/auth_screen.dart';
import 'features/auth/presentation/screens/splash/splash_screen.dart';
import 'features/chat/presentation/screens/chat_screen.dart';
import 'features/chat_inbox/presentation/screens/chat_search_screen.dart';
import 'features/videos/presentation/screens/video_player_screen.dart';
import 'ui/modals/create_post/create_post.dart';
import 'ui/screens/home/home_screen.dart';
import 'ui/screens/setup/setup_screen.dart';

class Routes {
  static const String splashScreen = '/';
  static const String homeScreen = '/home';
  static const String authScreen = '/auth';
  static const String setupScreen = '/setup';
  static const String createPost = '/create-post';
  static const String chatScreen = '/chat/user';
  static const String chatSearchScreen = '/chat/search';
  static const String videoPlayerScreen = '/video-player';
  static const all = <String>{
    splashScreen,
    homeScreen,
    authScreen,
    setupScreen,
    createPost,
    chatScreen,
    chatSearchScreen,
    videoPlayerScreen,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.splashScreen, page: SplashScreen),
    RouteDef(Routes.homeScreen, page: HomeScreen),
    RouteDef(Routes.authScreen, page: AuthScreen),
    RouteDef(Routes.setupScreen, page: SetupScreen),
    RouteDef(Routes.createPost, page: CreatePost),
    RouteDef(Routes.chatScreen, page: ChatScreen),
    RouteDef(Routes.chatSearchScreen, page: ChatSearchScreen),
    RouteDef(Routes.videoPlayerScreen, page: VideoPlayerScreen),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    SplashScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SplashScreen(),
        settings: data,
      );
    },
    HomeScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomeScreen(),
        settings: data,
      );
    },
    AuthScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => AuthScreen(),
        settings: data,
      );
    },
    SetupScreen: (data) {
      final args = data.getArgs<SetupScreenArguments>(
        orElse: () => SetupScreenArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => SetupScreen(
          key: args.key,
          initialTab: args.initialTab,
        ),
        settings: data,
      );
    },
    CreatePost: (data) {
      final args = data.getArgs<CreatePostArguments>(
        orElse: () => CreatePostArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => CreatePost(
          key: args.key,
          postBloc: args.postBloc,
        ),
        settings: data,
        fullscreenDialog: true,
      );
    },
    ChatScreen: (data) {
      final args = data.getArgs<ChatScreenArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => ChatScreen(
          key: args.key,
          recieverId: args.recieverId,
        ),
        settings: data,
      );
    },
    ChatSearchScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ChatSearchScreen(),
        settings: data,
      );
    },
    VideoPlayerScreen: (data) {
      final args = data.getArgs<VideoPlayerScreenArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => VideoPlayerScreen(
          videoId: args.videoId,
          key: args.key,
        ),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Navigation helper methods extension
/// *************************************************************************

extension RouterExtendedNavigatorStateX on ExtendedNavigatorState {
  Future<dynamic> pushSplashScreen() => push<dynamic>(Routes.splashScreen);

  Future<dynamic> pushHomeScreen() => push<dynamic>(Routes.homeScreen);

  Future<dynamic> pushAuthScreen() => push<dynamic>(Routes.authScreen);

  Future<dynamic> pushSetupScreen({
    Key key,
    String initialTab,
  }) =>
      push<dynamic>(
        Routes.setupScreen,
        arguments: SetupScreenArguments(key: key, initialTab: initialTab),
      );

  Future<dynamic> pushCreatePost({
    Key key,
    PostBloc postBloc,
  }) =>
      push<dynamic>(
        Routes.createPost,
        arguments: CreatePostArguments(key: key, postBloc: postBloc),
      );

  Future<dynamic> pushChatScreen({
    Key key,
    @required String recieverId,
  }) =>
      push<dynamic>(
        Routes.chatScreen,
        arguments: ChatScreenArguments(key: key, recieverId: recieverId),
      );

  Future<dynamic> pushChatSearchScreen() =>
      push<dynamic>(Routes.chatSearchScreen);

  Future<dynamic> pushVideoPlayerScreen({
    @required int videoId,
    Key key,
  }) =>
      push<dynamic>(
        Routes.videoPlayerScreen,
        arguments: VideoPlayerScreenArguments(videoId: videoId, key: key),
      );
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// SetupScreen arguments holder class
class SetupScreenArguments {
  final Key key;
  final String initialTab;
  SetupScreenArguments({this.key, this.initialTab});
}

/// CreatePost arguments holder class
class CreatePostArguments {
  final Key key;
  final PostBloc postBloc;
  CreatePostArguments({this.key, this.postBloc});
}

/// ChatScreen arguments holder class
class ChatScreenArguments {
  final Key key;
  final String recieverId;
  ChatScreenArguments({this.key, @required this.recieverId});
}

/// VideoPlayerScreen arguments holder class
class VideoPlayerScreenArguments {
  final int videoId;
  final Key key;
  VideoPlayerScreenArguments({@required this.videoId, this.key});
}
