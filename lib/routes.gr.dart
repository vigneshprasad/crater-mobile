// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i14;
import 'package:flutter/material.dart' as _i15;

import 'core/widgets/screens/home_screen/home_screen.dart' as _i2;
import 'features/auth/presentation/screens/onboarding/onboarding_screen.dart'
    as _i5;
import 'features/auth/presentation/screens/phone/phone_screen.dart' as _i4;
import 'features/auth/presentation/screens/splash/splash_screen.dart' as _i1;
import 'features/auth/presentation/screens/welcome/welcome_screen.dart' as _i3;
import 'features/chat/presentation/screens/chat_screen.dart' as _i6;
import 'features/club/presentation/screens/past_stream/past_stream_detail_screen.dart'
    as _i12;
import 'features/club/presentation/screens/streams/past_stream_screen.dart'
    as _i13;
import 'features/conversations/presentation/screens/conversation_screen/conversation_screen.dart'
    as _i7;
import 'features/conversations/presentation/screens/series_screen/series_screen.dart'
    as _i8;
import 'features/profile/presentation/screens/profile_screen/profile_screen.dart'
    as _i11;
import 'features/signup/presentation/screens/profile_basic_screen.dart' as _i9;
import 'features/signup/presentation/screens/profile_email_screen.dart' as _i10;

class AppRouter extends _i14.RootStackRouter {
  AppRouter([_i15.GlobalKey<_i15.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i14.PageFactory> pagesMap = {
    SplashScreenRoute.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData, child: _i1.SplashScreen());
    },
    HomeScreenRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<HomeScreenRouteArgs>(
          orElse: () => HomeScreenRouteArgs(tab: pathParams.optInt('tab', 0)));
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData, child: _i2.HomeScreen(tab: args.tab));
    },
    WelcomeScreenRoute.name: (routeData) {
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData, child: _i3.WelcomeScreen());
    },
    PhoneScreenRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<PhoneScreenRouteArgs>(
          orElse: () =>
              PhoneScreenRouteArgs(state: pathParams.getString('state')));
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i4.PhoneScreen(key: args.key, state: args.state));
    },
    OnboardingScreenRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<OnboardingScreenRouteArgs>(
          orElse: () =>
              OnboardingScreenRouteArgs(type: pathParams.getString('type')));
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData, child: _i5.OnboardingScreen(args.type));
    },
    ChatScreenRoute.name: (routeData) {
      final args = routeData.argsAs<ChatScreenRouteArgs>();
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i6.ChatScreen(
              recieverId: args.recieverId,
              groupId: args.groupId,
              allowChat: args.allowChat,
              creatorId: args.creatorId));
    },
    ConversationScreenRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ConversationScreenRouteArgs>(
          orElse: () =>
              ConversationScreenRouteArgs(id: pathParams.optInt('id')));
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData, child: _i7.ConversationScreen(id: args.id));
    },
    SeriesScreenRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<SeriesScreenRouteArgs>(
          orElse: () => SeriesScreenRouteArgs(id: pathParams.optInt('id')));
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData, child: _i8.SeriesScreen(id: args.id));
    },
    ProfileBasicScreenRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ProfileBasicScreenRouteArgs>(
          orElse: () => ProfileBasicScreenRouteArgs(
              editMode: pathParams.getBool('editMode')));
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i9.ProfileBasicScreen(
              key: args.key,
              editMode: args.editMode,
              onCompletion: args.onCompletion,
              popup: args.popup));
    },
    ProfileEmailScreenRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ProfileEmailScreenRouteArgs>(
          orElse: () => ProfileEmailScreenRouteArgs(
              editMode: pathParams.getBool('editMode')));
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i10.ProfileEmailScreen(
              key: args.key, editMode: args.editMode, popup: args.popup));
    },
    ProfileScreenRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ProfileScreenRouteArgs>(
          orElse: () => ProfileScreenRouteArgs(
              userId: pathParams.getString('userId'),
              createrId: pathParams.optInt('createrId'),
              allowEdit: pathParams.getBool('allowEdit')));
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i11.ProfileScreen(args.userId,
              createrId: args.createrId, allowEdit: args.allowEdit));
    },
    PastStreamDetailScreenRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<PastStreamDetailScreenRouteArgs>(
          orElse: () =>
              PastStreamDetailScreenRouteArgs(id: pathParams.optInt('id')));
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i12.PastStreamDetailScreen(id: args.id));
    },
    PastStreamScreenRoute.name: (routeData) {
      final args = routeData.argsAs<PastStreamScreenRouteArgs>(
          orElse: () => const PastStreamScreenRouteArgs());
      return _i14.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i13.PastStreamScreen(
              categoryId: args.categoryId, categoryName: args.categoryName));
    }
  };

  @override
  List<_i14.RouteConfig> get routes => [
        _i14.RouteConfig(SplashScreenRoute.name, path: '/'),
        _i14.RouteConfig(HomeScreenRoute.name, path: '/home/:tab?'),
        _i14.RouteConfig(WelcomeScreenRoute.name, path: '/welcome'),
        _i14.RouteConfig(PhoneScreenRoute.name, path: '/phone/:state?'),
        _i14.RouteConfig(OnboardingScreenRoute.name, path: '/onboarding/:type'),
        _i14.RouteConfig(ChatScreenRoute.name, path: '/chat/user'),
        _i14.RouteConfig(ConversationScreenRoute.name, path: '/roundtable/:id'),
        _i14.RouteConfig(SeriesScreenRoute.name, path: '/series/:id'),
        _i14.RouteConfig(ProfileBasicScreenRoute.name,
            path: '/profile-basic/:editMode?'),
        _i14.RouteConfig(ProfileEmailScreenRoute.name,
            path: '/profile-email/:editMode?'),
        _i14.RouteConfig(ProfileScreenRoute.name,
            path: '/profile-detail/:userId/:createrId?/:allowEdit'),
        _i14.RouteConfig(PastStreamDetailScreenRoute.name,
            path: '/past-stream/:id'),
        _i14.RouteConfig(PastStreamScreenRoute.name,
            path: '/past-streams/:categoryId?')
      ];
}

/// generated route for
/// [_i1.SplashScreen]
class SplashScreenRoute extends _i14.PageRouteInfo<void> {
  const SplashScreenRoute() : super(SplashScreenRoute.name, path: '/');

  static const String name = 'SplashScreenRoute';
}

/// generated route for
/// [_i2.HomeScreen]
class HomeScreenRoute extends _i14.PageRouteInfo<HomeScreenRouteArgs> {
  HomeScreenRoute({int? tab = 0})
      : super(HomeScreenRoute.name,
            path: '/home/:tab?',
            args: HomeScreenRouteArgs(tab: tab),
            rawPathParams: {'tab': tab});

  static const String name = 'HomeScreenRoute';
}

class HomeScreenRouteArgs {
  const HomeScreenRouteArgs({this.tab = 0});

  final int? tab;

  @override
  String toString() {
    return 'HomeScreenRouteArgs{tab: $tab}';
  }
}

/// generated route for
/// [_i3.WelcomeScreen]
class WelcomeScreenRoute extends _i14.PageRouteInfo<void> {
  const WelcomeScreenRoute() : super(WelcomeScreenRoute.name, path: '/welcome');

  static const String name = 'WelcomeScreenRoute';
}

/// generated route for
/// [_i4.PhoneScreen]
class PhoneScreenRoute extends _i14.PageRouteInfo<PhoneScreenRouteArgs> {
  PhoneScreenRoute({_i15.Key? key, required String state})
      : super(PhoneScreenRoute.name,
            path: '/phone/:state?',
            args: PhoneScreenRouteArgs(key: key, state: state),
            rawPathParams: {'state': state});

  static const String name = 'PhoneScreenRoute';
}

class PhoneScreenRouteArgs {
  const PhoneScreenRouteArgs({this.key, required this.state});

  final _i15.Key? key;

  final String state;

  @override
  String toString() {
    return 'PhoneScreenRouteArgs{key: $key, state: $state}';
  }
}

/// generated route for
/// [_i5.OnboardingScreen]
class OnboardingScreenRoute
    extends _i14.PageRouteInfo<OnboardingScreenRouteArgs> {
  OnboardingScreenRoute({required String type})
      : super(OnboardingScreenRoute.name,
            path: '/onboarding/:type',
            args: OnboardingScreenRouteArgs(type: type),
            rawPathParams: {'type': type});

  static const String name = 'OnboardingScreenRoute';
}

class OnboardingScreenRouteArgs {
  const OnboardingScreenRouteArgs({required this.type});

  final String type;

  @override
  String toString() {
    return 'OnboardingScreenRouteArgs{type: $type}';
  }
}

/// generated route for
/// [_i6.ChatScreen]
class ChatScreenRoute extends _i14.PageRouteInfo<ChatScreenRouteArgs> {
  ChatScreenRoute(
      {required String recieverId,
      String? groupId,
      bool? allowChat = true,
      required int creatorId})
      : super(ChatScreenRoute.name,
            path: '/chat/user',
            args: ChatScreenRouteArgs(
                recieverId: recieverId,
                groupId: groupId,
                allowChat: allowChat,
                creatorId: creatorId));

  static const String name = 'ChatScreenRoute';
}

class ChatScreenRouteArgs {
  const ChatScreenRouteArgs(
      {required this.recieverId,
      this.groupId,
      this.allowChat = true,
      required this.creatorId});

  final String recieverId;

  final String? groupId;

  final bool? allowChat;

  final int creatorId;

  @override
  String toString() {
    return 'ChatScreenRouteArgs{recieverId: $recieverId, groupId: $groupId, allowChat: $allowChat, creatorId: $creatorId}';
  }
}

/// generated route for
/// [_i7.ConversationScreen]
class ConversationScreenRoute
    extends _i14.PageRouteInfo<ConversationScreenRouteArgs> {
  ConversationScreenRoute({int? id})
      : super(ConversationScreenRoute.name,
            path: '/roundtable/:id',
            args: ConversationScreenRouteArgs(id: id),
            rawPathParams: {'id': id});

  static const String name = 'ConversationScreenRoute';
}

class ConversationScreenRouteArgs {
  const ConversationScreenRouteArgs({this.id});

  final int? id;

  @override
  String toString() {
    return 'ConversationScreenRouteArgs{id: $id}';
  }
}

/// generated route for
/// [_i8.SeriesScreen]
class SeriesScreenRoute extends _i14.PageRouteInfo<SeriesScreenRouteArgs> {
  SeriesScreenRoute({int? id})
      : super(SeriesScreenRoute.name,
            path: '/series/:id',
            args: SeriesScreenRouteArgs(id: id),
            rawPathParams: {'id': id});

  static const String name = 'SeriesScreenRoute';
}

class SeriesScreenRouteArgs {
  const SeriesScreenRouteArgs({this.id});

  final int? id;

  @override
  String toString() {
    return 'SeriesScreenRouteArgs{id: $id}';
  }
}

/// generated route for
/// [_i9.ProfileBasicScreen]
class ProfileBasicScreenRoute
    extends _i14.PageRouteInfo<ProfileBasicScreenRouteArgs> {
  ProfileBasicScreenRoute(
      {_i15.Key? key,
      required bool editMode,
      void Function()? onCompletion,
      bool? popup = false})
      : super(ProfileBasicScreenRoute.name,
            path: '/profile-basic/:editMode?',
            args: ProfileBasicScreenRouteArgs(
                key: key,
                editMode: editMode,
                onCompletion: onCompletion,
                popup: popup),
            rawPathParams: {'editMode': editMode});

  static const String name = 'ProfileBasicScreenRoute';
}

class ProfileBasicScreenRouteArgs {
  const ProfileBasicScreenRouteArgs(
      {this.key,
      required this.editMode,
      this.onCompletion,
      this.popup = false});

  final _i15.Key? key;

  final bool editMode;

  final void Function()? onCompletion;

  final bool? popup;

  @override
  String toString() {
    return 'ProfileBasicScreenRouteArgs{key: $key, editMode: $editMode, onCompletion: $onCompletion, popup: $popup}';
  }
}

/// generated route for
/// [_i10.ProfileEmailScreen]
class ProfileEmailScreenRoute
    extends _i14.PageRouteInfo<ProfileEmailScreenRouteArgs> {
  ProfileEmailScreenRoute(
      {_i15.Key? key, required bool editMode, bool? popup = false})
      : super(ProfileEmailScreenRoute.name,
            path: '/profile-email/:editMode?',
            args: ProfileEmailScreenRouteArgs(
                key: key, editMode: editMode, popup: popup),
            rawPathParams: {'editMode': editMode});

  static const String name = 'ProfileEmailScreenRoute';
}

class ProfileEmailScreenRouteArgs {
  const ProfileEmailScreenRouteArgs(
      {this.key, required this.editMode, this.popup = false});

  final _i15.Key? key;

  final bool editMode;

  final bool? popup;

  @override
  String toString() {
    return 'ProfileEmailScreenRouteArgs{key: $key, editMode: $editMode, popup: $popup}';
  }
}

/// generated route for
/// [_i11.ProfileScreen]
class ProfileScreenRoute extends _i14.PageRouteInfo<ProfileScreenRouteArgs> {
  ProfileScreenRoute(
      {required String userId, int? createrId, required bool allowEdit})
      : super(ProfileScreenRoute.name,
            path: '/profile-detail/:userId/:createrId?/:allowEdit',
            args: ProfileScreenRouteArgs(
                userId: userId, createrId: createrId, allowEdit: allowEdit),
            rawPathParams: {
              'userId': userId,
              'createrId': createrId,
              'allowEdit': allowEdit
            });

  static const String name = 'ProfileScreenRoute';
}

class ProfileScreenRouteArgs {
  const ProfileScreenRouteArgs(
      {required this.userId, this.createrId, required this.allowEdit});

  final String userId;

  final int? createrId;

  final bool allowEdit;

  @override
  String toString() {
    return 'ProfileScreenRouteArgs{userId: $userId, createrId: $createrId, allowEdit: $allowEdit}';
  }
}

/// generated route for
/// [_i12.PastStreamDetailScreen]
class PastStreamDetailScreenRoute
    extends _i14.PageRouteInfo<PastStreamDetailScreenRouteArgs> {
  PastStreamDetailScreenRoute({int? id})
      : super(PastStreamDetailScreenRoute.name,
            path: '/past-stream/:id',
            args: PastStreamDetailScreenRouteArgs(id: id),
            rawPathParams: {'id': id});

  static const String name = 'PastStreamDetailScreenRoute';
}

class PastStreamDetailScreenRouteArgs {
  const PastStreamDetailScreenRouteArgs({this.id});

  final int? id;

  @override
  String toString() {
    return 'PastStreamDetailScreenRouteArgs{id: $id}';
  }
}

/// generated route for
/// [_i13.PastStreamScreen]
class PastStreamScreenRoute
    extends _i14.PageRouteInfo<PastStreamScreenRouteArgs> {
  PastStreamScreenRoute({int? categoryId, String? categoryName})
      : super(PastStreamScreenRoute.name,
            path: '/past-streams/:categoryId?',
            args: PastStreamScreenRouteArgs(
                categoryId: categoryId, categoryName: categoryName));

  static const String name = 'PastStreamScreenRoute';
}

class PastStreamScreenRouteArgs {
  const PastStreamScreenRouteArgs({this.categoryId, this.categoryName});

  final int? categoryId;

  final String? categoryName;

  @override
  String toString() {
    return 'PastStreamScreenRouteArgs{categoryId: $categoryId, categoryName: $categoryName}';
  }
}
