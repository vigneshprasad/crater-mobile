// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'core/widgets/screens/home_screen.dart';
import 'features/auth/presentation/screens/auth/auth_screen.dart';
import 'features/auth/presentation/screens/forgot_password/forgot_password_screen.dart';
import 'features/auth/presentation/screens/splash/splash_screen.dart';
import 'features/chat/presentation/screens/chat_screen.dart';
import 'features/chat_inbox/presentation/screens/chat_search_screen.dart';
import 'features/community/presentation/screens/create_post.dart';
import 'features/community/presentation/screens/post_screen.dart';
import 'features/meeting/domain/entity/meeting_config_entity.dart';
import 'features/meeting/domain/entity/meeting_interest_entity.dart';
import 'features/meeting/domain/entity/meeting_objective_entity.dart';
import 'features/meeting/domain/entity/user_meeting_preference_entity.dart';
import 'features/meeting/presentation/screens/meeting_details_screen.dart';
import 'features/meeting/presentation/screens/register_meeting_screen.dart';
import 'features/notification/presentation/screens/notifications_screen.dart';
import 'features/points/presentation/screens/points_faq_screen.dart';
import 'features/rewards/domain/entity/package_entity.dart';
import 'features/rewards/presentation/screens/package_detail_screen.dart';
import 'features/rewards/presentation/screens/package_purchase_screen.dart';
import 'features/signup/presentation/screens/objectives_screen.dart';
import 'features/signup/presentation/screens/phone_verification_screen.dart';
import 'features/signup/presentation/screens/profile_setup_screen.dart';
import 'features/videos/presentation/screens/video_player_screen.dart';

class Routes {
  static const String splashScreen = '/';
  static const String _homeScreen = '/home/:tab?';
  static String homeScreen({dynamic tab = ''}) => '/home/$tab';
  static const String objectivesScreen = '/objectives';
  static const String profileSetupScreen = '/profile-setup';
  static const String phoneVerificationScreen = '/phone-verify';
  static const String authScreen = '/auth';
  static const String forgotPasswordScreen = '/forgot-password';
  static const String createPostScreen = '/create-post';
  static const String chatScreen = '/chat/user';
  static const String chatSearchScreen = '/chat/search';
  static const String videoPlayerScreen = '/video-player';
  static const String notificationsScreen = '/notifications';
  static const String postScreen = '/post';
  static const String registerMeetingScreen = '/register-meeting';
  static const String meetingDetailScreen = '/meeting-detail';
  static const String packageDetailScreen = '/package-detail';
  static const String packagePurchaseScreen = '/package-purchase';
  static const String pointsFaqScreen = '/points-faq';
  static const all = <String>{
    splashScreen,
    _homeScreen,
    objectivesScreen,
    profileSetupScreen,
    phoneVerificationScreen,
    authScreen,
    forgotPasswordScreen,
    createPostScreen,
    chatScreen,
    chatSearchScreen,
    videoPlayerScreen,
    notificationsScreen,
    postScreen,
    registerMeetingScreen,
    meetingDetailScreen,
    packageDetailScreen,
    packagePurchaseScreen,
    pointsFaqScreen,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.splashScreen, page: SplashScreen),
    RouteDef(Routes._homeScreen, page: HomeScreen),
    RouteDef(Routes.objectivesScreen, page: ObjectivesScreen),
    RouteDef(Routes.profileSetupScreen, page: ProfileSetupScreen),
    RouteDef(Routes.phoneVerificationScreen, page: PhoneVerificationScreen),
    RouteDef(Routes.authScreen, page: AuthScreen),
    RouteDef(Routes.forgotPasswordScreen, page: ForgotPasswordScreen),
    RouteDef(Routes.createPostScreen, page: CreatePostScreen),
    RouteDef(Routes.chatScreen, page: ChatScreen),
    RouteDef(Routes.chatSearchScreen, page: ChatSearchScreen),
    RouteDef(Routes.videoPlayerScreen, page: VideoPlayerScreen),
    RouteDef(Routes.notificationsScreen, page: NotificationsScreen),
    RouteDef(Routes.postScreen, page: PostScreen),
    RouteDef(Routes.registerMeetingScreen, page: RegisterMeetingScreen),
    RouteDef(Routes.meetingDetailScreen, page: MeetingDetailScreen),
    RouteDef(Routes.packageDetailScreen, page: PackageDetailScreen),
    RouteDef(Routes.packagePurchaseScreen, page: PackagePurchaseScreen),
    RouteDef(Routes.pointsFaqScreen, page: PointsFaqScreen),
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
        builder: (context) =>
            HomeScreen(tabIndex: data.pathParams['tab'].intValue),
        settings: data,
      );
    },
    ObjectivesScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ObjectivesScreen(),
        settings: data,
      );
    },
    ProfileSetupScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ProfileSetupScreen(),
        settings: data,
      );
    },
    PhoneVerificationScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => PhoneVerificationScreen(),
        settings: data,
      );
    },
    AuthScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => AuthScreen(),
        settings: data,
      );
    },
    ForgotPasswordScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => ForgotPasswordScreen(),
        settings: data,
      );
    },
    CreatePostScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => CreatePostScreen(),
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
    NotificationsScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => NotificationsScreen(),
        settings: data,
      );
    },
    PostScreen: (data) {
      final args = data.getArgs<PostScreenArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => PostScreen(
          key: args.key,
          postId: args.postId,
        ),
        settings: data,
      );
    },
    RegisterMeetingScreen: (data) {
      final args = data.getArgs<RegisterMeetingScreenArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => RegisterMeetingScreen(
          key: args.key,
          config: args.config,
          preference: args.preference,
          objectives: args.objectives,
          interests: args.interests,
        ),
        settings: data,
      );
    },
    MeetingDetailScreen: (data) {
      final args = data.getArgs<MeetingDetailScreenArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => MeetingDetailScreen(
          key: args.key,
          meetingId: args.meetingId,
        ),
        settings: data,
      );
    },
    PackageDetailScreen: (data) {
      final args = data.getArgs<PackageDetailScreenArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => PackageDetailScreen(
          key: args.key,
          packageId: args.packageId,
        ),
        settings: data,
      );
    },
    PackagePurchaseScreen: (data) {
      final args = data.getArgs<PackagePurchaseScreenArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => PackagePurchaseScreen(
          key: args.key,
          package: args.package,
        ),
        settings: data,
      );
    },
    PointsFaqScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => PointsFaqScreen(),
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

  Future<dynamic> pushObjectivesScreen() =>
      push<dynamic>(Routes.objectivesScreen);

  Future<dynamic> pushProfileSetupScreen() =>
      push<dynamic>(Routes.profileSetupScreen);

  Future<dynamic> pushPhoneVerificationScreen() =>
      push<dynamic>(Routes.phoneVerificationScreen);

  Future<dynamic> pushAuthScreen() => push<dynamic>(Routes.authScreen);

  Future<dynamic> pushForgotPasswordScreen() =>
      push<dynamic>(Routes.forgotPasswordScreen);

  Future<dynamic> pushCreatePostScreen() =>
      push<dynamic>(Routes.createPostScreen);

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

  Future<dynamic> pushNotificationsScreen() =>
      push<dynamic>(Routes.notificationsScreen);

  Future<dynamic> pushPostScreen({
    Key key,
    @required int postId,
  }) =>
      push<dynamic>(
        Routes.postScreen,
        arguments: PostScreenArguments(key: key, postId: postId),
      );

  Future<dynamic> pushRegisterMeetingScreen({
    Key key,
    @required MeetingConfig config,
    @required UserMeetingPreference preference,
    @required List<MeetingObjective> objectives,
    @required List<MeetingInterest> interests,
  }) =>
      push<dynamic>(
        Routes.registerMeetingScreen,
        arguments: RegisterMeetingScreenArguments(
            key: key,
            config: config,
            preference: preference,
            objectives: objectives,
            interests: interests),
      );

  Future<dynamic> pushMeetingDetailScreen({
    Key key,
    @required int meetingId,
  }) =>
      push<dynamic>(
        Routes.meetingDetailScreen,
        arguments: MeetingDetailScreenArguments(key: key, meetingId: meetingId),
      );

  Future<dynamic> pushPackageDetailScreen({
    Key key,
    @required int packageId,
  }) =>
      push<dynamic>(
        Routes.packageDetailScreen,
        arguments: PackageDetailScreenArguments(key: key, packageId: packageId),
      );

  Future<dynamic> pushPackagePurchaseScreen({
    Key key,
    @required Package package,
  }) =>
      push<dynamic>(
        Routes.packagePurchaseScreen,
        arguments: PackagePurchaseScreenArguments(key: key, package: package),
      );

  Future<dynamic> pushPointsFaqScreen() =>
      push<dynamic>(Routes.pointsFaqScreen);
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

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

/// PostScreen arguments holder class
class PostScreenArguments {
  final Key key;
  final int postId;
  PostScreenArguments({this.key, @required this.postId});
}

/// RegisterMeetingScreen arguments holder class
class RegisterMeetingScreenArguments {
  final Key key;
  final MeetingConfig config;
  final UserMeetingPreference preference;
  final List<MeetingObjective> objectives;
  final List<MeetingInterest> interests;
  RegisterMeetingScreenArguments(
      {this.key,
      @required this.config,
      @required this.preference,
      @required this.objectives,
      @required this.interests});
}

/// MeetingDetailScreen arguments holder class
class MeetingDetailScreenArguments {
  final Key key;
  final int meetingId;
  MeetingDetailScreenArguments({this.key, @required this.meetingId});
}

/// PackageDetailScreen arguments holder class
class PackageDetailScreenArguments {
  final Key key;
  final int packageId;
  PackageDetailScreenArguments({this.key, @required this.packageId});
}

/// PackagePurchaseScreen arguments holder class
class PackagePurchaseScreenArguments {
  final Key key;
  final Package package;
  PackagePurchaseScreenArguments({this.key, @required this.package});
}
