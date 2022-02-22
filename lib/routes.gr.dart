// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import 'core/widgets/screens/home_screen/home_screen.dart' as _i4;
import 'features/auth/presentation/screens/auth/auth_screen.dart' as _i12;
import 'features/auth/presentation/screens/forgot_password/forgot_password_screen.dart'
    as _i14;
import 'features/auth/presentation/screens/new_password/new_password_screen.dart'
    as _i38;
import 'features/auth/presentation/screens/onboarding/onboarding_screen.dart'
    as _i15;
import 'features/auth/presentation/screens/phone/phone_screen.dart' as _i13;
import 'features/auth/presentation/screens/splash/splash_screen.dart' as _i3;
import 'features/auth/presentation/screens/welcome/welcome_screen.dart' as _i7;
import 'features/chat/presentation/screens/chat_screen.dart' as _i17;
import 'features/chat_inbox/presentation/screens/chat_search_screen.dart'
    as _i18;
import 'features/club/presentation/screens/past_stream/past_stream_screen.dart'
    as _i40;
import 'features/community/presentation/screens/create_post.dart' as _i16;
import 'features/community/presentation/screens/post_screen.dart' as _i21;
import 'features/conversations/domain/entity/topic_entity/topic_entity.dart'
    as _i46;
import 'features/conversations/presentation/screens/conversation_screen_2/conversation_screen.dart'
    as _i28;
import 'features/conversations/presentation/screens/create_conversation_screen/create_conversation_screen.dart'
    as _i30;
import 'features/conversations/presentation/screens/create_conversation_screen/create_conversation_state.dart'
    as _i47;
import 'features/conversations/presentation/screens/series_screen/series_screen.dart'
    as _i29;
import 'features/conversations/presentation/widgets/topics_list/topics_list.dart'
    as _i6;
import 'features/conversations/presentation/widgets/topics_tab/topics_tab.dart'
    as _i5;
import 'features/meeting/domain/entity/meeting_config_entity.dart' as _i41;
import 'features/meeting/domain/entity/meeting_interest_entity.dart' as _i44;
import 'features/meeting/domain/entity/meeting_objective_entity.dart' as _i43;
import 'features/meeting/domain/entity/user_meeting_preference_entity.dart'
    as _i42;
import 'features/meeting/presentation/screens/meeting_details_screen.dart'
    as _i23;
import 'features/meeting/presentation/screens/meeting_request_details_screen.dart'
    as _i24;
import 'features/meeting/presentation/screens/register_meeting_screen.dart'
    as _i22;
import 'features/notification/presentation/screens/notifications_screen.dart'
    as _i20;
import 'features/points/presentation/screens/points_faq_screen.dart' as _i27;
import 'features/profile/presentation/screens/profile_screen/profile_screen.dart'
    as _i39;
import 'features/rewards/domain/entity/package_entity.dart' as _i45;
import 'features/rewards/presentation/screens/package_detail_screen.dart'
    as _i25;
import 'features/rewards/presentation/screens/package_purchase_screen.dart'
    as _i26;
import 'features/signup/presentation/screens/objectives_screen.dart' as _i8;
import 'features/signup/presentation/screens/phone_verification_screen.dart'
    as _i11;
import 'features/signup/presentation/screens/profile_basic_screen.dart' as _i32;
import 'features/signup/presentation/screens/profile_bio_screen.dart' as _i35;
import 'features/signup/presentation/screens/profile_email_screen.dart' as _i36;
import 'features/signup/presentation/screens/profile_extra_info_screen/profile_intro_screen.dart'
    as _i10;
import 'features/signup/presentation/screens/profile_image_screen.dart' as _i34;
import 'features/signup/presentation/screens/profile_intro_screen.dart' as _i31;
import 'features/signup/presentation/screens/profile_request_screen.dart'
    as _i37;
import 'features/signup/presentation/screens/profile_setup_screen.dart' as _i9;
import 'features/signup/presentation/screens/profile_tags_screen.dart' as _i33;
import 'features/videos/presentation/screens/video_player_screen.dart' as _i19;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    SplashScreenRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i3.SplashScreen();
        }),
    HomeScreenRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final pathParams = data.pathParams;
          final args = data.argsAs<HomeScreenRouteArgs>(
              orElse: () => HomeScreenRouteArgs(tab: pathParams.optInt('tab')));
          return _i4.HomeScreen(tab: args.tab);
        }),
    TopicsTabRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<TopicsTabRouteArgs>();
          return _i5.TopicsTab(topic: args.topic);
        }),
    TopicsListRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final pathParams = data.pathParams;
          final args = data.argsAs<TopicsListRouteArgs>(
              orElse: () => TopicsListRouteArgs(
                  showTitle: pathParams.getBool('editMode')));
          return _i6.TopicsList(key: args.key, showTitle: args.showTitle);
        }),
    WelcomeScreenRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i7.WelcomeScreen();
        }),
    ObjectivesScreenRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i8.ObjectivesScreen();
        }),
    ProfileSetupScreenRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final pathParams = data.pathParams;
          final args = data.argsAs<ProfileSetupScreenRouteArgs>(
              orElse: () => ProfileSetupScreenRouteArgs(
                  editMode: pathParams.getBool('editMode')));
          return _i9.ProfileSetupScreen(key: args.key, editMode: args.editMode);
        }),
    ProfileExtraInfoScreenRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final pathParams = data.pathParams;
          final args = data.argsAs<ProfileExtraInfoScreenRouteArgs>(
              orElse: () => ProfileExtraInfoScreenRouteArgs(
                  editMode: pathParams.getBool('editMode')));
          return _i10.ProfileExtraInfoScreen(
              key: args.key, editMode: args.editMode);
        }),
    PhoneVerificationScreenRoute.name: (routeData) =>
        _i1.MaterialPageX<dynamic>(
            routeData: routeData,
            builder: (_) {
              return _i11.PhoneVerificationScreen();
            }),
    AuthScreenRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final pathParams = data.pathParams;
          final args = data.argsAs<AuthScreenRouteArgs>(
              orElse: () =>
                  AuthScreenRouteArgs(state: pathParams.getString('state')));
          return _i12.AuthScreen(key: args.key, state: args.state);
        }),
    PhoneScreenRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final pathParams = data.pathParams;
          final args = data.argsAs<PhoneScreenRouteArgs>(
              orElse: () =>
                  PhoneScreenRouteArgs(state: pathParams.getString('state')));
          return _i13.PhoneScreen(key: args.key, state: args.state);
        }),
    ForgotPasswordScreenRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i14.ForgotPasswordScreen();
        }),
    OnboardingScreenRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final pathParams = data.pathParams;
          final args = data.argsAs<OnboardingScreenRouteArgs>(
              orElse: () => OnboardingScreenRouteArgs(
                  type: pathParams.getString('type')));
          return _i15.OnboardingScreen(args.type);
        }),
    CreatePostScreenRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i16.CreatePostScreen();
        },
        fullscreenDialog: true),
    ChatScreenRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<ChatScreenRouteArgs>();
          return _i17.ChatScreen(
              key: args.key,
              recieverId: args.recieverId,
              groupId: args.groupId);
        }),
    ChatSearchScreenRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i18.ChatSearchScreen();
        }),
    VideoPlayerScreenRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<VideoPlayerScreenRouteArgs>();
          return _i19.VideoPlayerScreen(videoId: args.videoId, key: args.key);
        }),
    NotificationsScreenRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i20.NotificationsScreen();
        }),
    PostScreenRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<PostScreenRouteArgs>();
          return _i21.PostScreen(key: args.key, postId: args.postId);
        }),
    RegisterMeetingScreenRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<RegisterMeetingScreenRouteArgs>();
          return _i22.RegisterMeetingScreen(
              key: args.key,
              config: args.config,
              preference: args.preference,
              objectives: args.objectives,
              interests: args.interests);
        }),
    MeetingDetailScreenRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<MeetingDetailScreenRouteArgs>();
          return _i23.MeetingDetailScreen(
              key: args.key, meetingId: args.meetingId);
        }),
    MeetingRequestDetailScreenRoute.name: (routeData) =>
        _i1.MaterialPageX<dynamic>(
            routeData: routeData,
            builder: (data) {
              final args = data.argsAs<MeetingRequestDetailScreenRouteArgs>();
              return _i24.MeetingRequestDetailScreen(
                  key: args.key, meetingId: args.meetingId);
            }),
    PackageDetailScreenRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<PackageDetailScreenRouteArgs>();
          return _i25.PackageDetailScreen(
              key: args.key, packageId: args.packageId);
        }),
    PackagePurchaseScreenRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<PackagePurchaseScreenRouteArgs>();
          return _i26.PackagePurchaseScreen(
              key: args.key, package: args.package);
        }),
    PointsFaqScreenRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i27.PointsFaqScreen();
        }),
    ConversationScreenRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final pathParams = data.pathParams;
          final args = data.argsAs<ConversationScreenRouteArgs>(
              orElse: () =>
                  ConversationScreenRouteArgs(id: pathParams.optInt('id')));
          return _i28.ConversationScreen(id: args.id);
        }),
    SeriesScreenRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final pathParams = data.pathParams;
          final args = data.argsAs<SeriesScreenRouteArgs>(
              orElse: () => SeriesScreenRouteArgs(id: pathParams.optInt('id')));
          return _i29.SeriesScreen(id: args.id);
        }),
    CreateConversationScreenRoute.name: (routeData) =>
        _i1.MaterialPageX<dynamic>(
            routeData: routeData,
            builder: (data) {
              final args = data.argsAs<CreateConversationScreenRouteArgs>();
              return _i30.CreateConversationScreen(
                  key: args.key, topic: args.topic, type: args.type);
            }),
    ProfileIntroScreenRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final pathParams = data.pathParams;
          final args = data.argsAs<ProfileIntroScreenRouteArgs>(
              orElse: () => ProfileIntroScreenRouteArgs(
                  editMode: pathParams.getBool('editMode')));
          return _i31.ProfileIntroScreen(
              key: args.key, editMode: args.editMode);
        }),
    ProfileBasicScreenRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final pathParams = data.pathParams;
          final args = data.argsAs<ProfileBasicScreenRouteArgs>(
              orElse: () => ProfileBasicScreenRouteArgs(
                  editMode: pathParams.getBool('editMode')));
          return _i32.ProfileBasicScreen(
              key: args.key, editMode: args.editMode);
        }),
    ProfileTagsScreenRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final pathParams = data.pathParams;
          final args = data.argsAs<ProfileTagsScreenRouteArgs>(
              orElse: () => ProfileTagsScreenRouteArgs(
                  editMode: pathParams.getBool('editMode')));
          return _i33.ProfileTagsScreen(key: args.key, editMode: args.editMode);
        }),
    ProfileImageScreenRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final pathParams = data.pathParams;
          final args = data.argsAs<ProfileImageScreenRouteArgs>(
              orElse: () => ProfileImageScreenRouteArgs(
                  editMode: pathParams.getBool('editMode')));
          return _i34.ProfileImageScreen(
              key: args.key, editMode: args.editMode);
        }),
    ProfileBioScreenRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final pathParams = data.pathParams;
          final args = data.argsAs<ProfileBioScreenRouteArgs>(
              orElse: () => ProfileBioScreenRouteArgs(
                  editMode: pathParams.getBool('editMode')));
          return _i35.ProfileBioScreen(key: args.key, editMode: args.editMode);
        }),
    ProfileEmailScreenRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final pathParams = data.pathParams;
          final args = data.argsAs<ProfileEmailScreenRouteArgs>(
              orElse: () => ProfileEmailScreenRouteArgs(
                  editMode: pathParams.getBool('editMode')));
          return _i36.ProfileEmailScreen(
              key: args.key, editMode: args.editMode);
        }),
    ProfileRequestScreenRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final pathParams = data.pathParams;
          final args = data.argsAs<ProfileRequestScreenRouteArgs>(
              orElse: () => ProfileRequestScreenRouteArgs(
                  editMode: pathParams.getBool('editMode')));
          return _i37.ProfileRequestScreen(
              key: args.key, editMode: args.editMode);
        }),
    NewPasswordScreenRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final pathParams = data.pathParams;
          final args = data.argsAs<NewPasswordScreenRouteArgs>(
              orElse: () => NewPasswordScreenRouteArgs(
                  params: pathParams.optString('params')));
          return _i38.NewPasswordScreen(key: args.key, params: args.params);
        }),
    ProfileScreenRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final pathParams = data.pathParams;
          final args = data.argsAs<ProfileScreenRouteArgs>(
              orElse: () => ProfileScreenRouteArgs(
                  userId: pathParams.getString('userId'),
                  createrId: pathParams.optInt('createrId'),
                  allowEdit: pathParams.getBool('allowEdit')));
          return _i39.ProfileScreen(args.userId,
              createrId: args.createrId, allowEdit: args.allowEdit);
        }),
    PastStreamScreenRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final pathParams = data.pathParams;
          final args = data.argsAs<PastStreamScreenRouteArgs>(
              orElse: () =>
                  PastStreamScreenRouteArgs(id: pathParams.optInt('id')));
          return _i40.PastStreamScreen(id: args.id);
        })
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(SplashScreenRoute.name, path: '/'),
        _i1.RouteConfig(HomeScreenRoute.name, path: '/home/:tab?'),
        _i1.RouteConfig(TopicsTabRoute.name, path: '/topic-list/:topic?'),
        _i1.RouteConfig(TopicsListRoute.name, path: '/topic-1on1'),
        _i1.RouteConfig(WelcomeScreenRoute.name, path: '/welcome'),
        _i1.RouteConfig(ObjectivesScreenRoute.name, path: '/objectives'),
        _i1.RouteConfig(ProfileSetupScreenRoute.name,
            path: '/profile-setup/:editMode?'),
        _i1.RouteConfig(ProfileExtraInfoScreenRoute.name,
            path: '/profile-extra-info/:editMode?'),
        _i1.RouteConfig(PhoneVerificationScreenRoute.name,
            path: '/phone-verify'),
        _i1.RouteConfig(AuthScreenRoute.name, path: '/auth/:state?'),
        _i1.RouteConfig(PhoneScreenRoute.name, path: '/phone/:state?'),
        _i1.RouteConfig(ForgotPasswordScreenRoute.name,
            path: '/forgot-password'),
        _i1.RouteConfig(OnboardingScreenRoute.name, path: '/onboarding/:type'),
        _i1.RouteConfig(CreatePostScreenRoute.name, path: '/create-post'),
        _i1.RouteConfig(ChatScreenRoute.name, path: '/chat/user'),
        _i1.RouteConfig(ChatSearchScreenRoute.name, path: '/chat/search'),
        _i1.RouteConfig(VideoPlayerScreenRoute.name, path: '/video-player'),
        _i1.RouteConfig(NotificationsScreenRoute.name, path: '/notifications'),
        _i1.RouteConfig(PostScreenRoute.name, path: '/post'),
        _i1.RouteConfig(RegisterMeetingScreenRoute.name,
            path: '/register-meeting'),
        _i1.RouteConfig(MeetingDetailScreenRoute.name, path: '/meeting-detail'),
        _i1.RouteConfig(MeetingRequestDetailScreenRoute.name,
            path: '/meeting-request-detail'),
        _i1.RouteConfig(PackageDetailScreenRoute.name, path: '/package-detail'),
        _i1.RouteConfig(PackagePurchaseScreenRoute.name,
            path: '/package-purchase'),
        _i1.RouteConfig(PointsFaqScreenRoute.name, path: '/points-faq'),
        _i1.RouteConfig(ConversationScreenRoute.name, path: '/roundtable/:id'),
        _i1.RouteConfig(SeriesScreenRoute.name, path: '/series/:id'),
        _i1.RouteConfig(CreateConversationScreenRoute.name,
            path: '/create-conversation'),
        _i1.RouteConfig(ProfileIntroScreenRoute.name,
            path: '/profile-intro/:editMode?'),
        _i1.RouteConfig(ProfileBasicScreenRoute.name,
            path: '/profile-basic/:editMode?'),
        _i1.RouteConfig(ProfileTagsScreenRoute.name,
            path: '/profile-tags/:editMode?'),
        _i1.RouteConfig(ProfileImageScreenRoute.name,
            path: '/profile-image/:editMode?'),
        _i1.RouteConfig(ProfileBioScreenRoute.name,
            path: '/profile-bio/:editMode?'),
        _i1.RouteConfig(ProfileEmailScreenRoute.name,
            path: '/profile-email/:editMode?'),
        _i1.RouteConfig(ProfileRequestScreenRoute.name,
            path: '/profile-request-settings/:editMode?'),
        _i1.RouteConfig(NewPasswordScreenRoute.name,
            path: '/new-password/:params?'),
        _i1.RouteConfig(ProfileScreenRoute.name,
            path: '/profile-detail/:userId/:allowEdit'),
        _i1.RouteConfig(PastStreamScreenRoute.name, path: '/past-stream/:id')
      ];
}

class SplashScreenRoute extends _i1.PageRouteInfo {
  const SplashScreenRoute() : super(name, path: '/');

  static const String name = 'SplashScreenRoute';
}

class HomeScreenRoute extends _i1.PageRouteInfo<HomeScreenRouteArgs> {
  HomeScreenRoute({int? tab})
      : super(name,
            path: '/home/:tab?',
            args: HomeScreenRouteArgs(tab: tab),
            rawPathParams: {'tab': tab});

  static const String name = 'HomeScreenRoute';
}

class HomeScreenRouteArgs {
  const HomeScreenRouteArgs({this.tab});

  final int? tab;
}

class TopicsTabRoute extends _i1.PageRouteInfo<TopicsTabRouteArgs> {
  TopicsTabRoute({required _i2.ValueNotifier<int> topic})
      : super(name,
            path: '/topic-list/:topic?',
            args: TopicsTabRouteArgs(topic: topic),
            rawPathParams: {});

  static const String name = 'TopicsTabRoute';
}

class TopicsTabRouteArgs {
  const TopicsTabRouteArgs({required this.topic});

  final _i2.ValueNotifier<int> topic;
}

class TopicsListRoute extends _i1.PageRouteInfo<TopicsListRouteArgs> {
  TopicsListRoute({_i2.Key? key, required bool showTitle})
      : super(name,
            path: '/topic-1on1',
            args: TopicsListRouteArgs(key: key, showTitle: showTitle));

  static const String name = 'TopicsListRoute';
}

class TopicsListRouteArgs {
  const TopicsListRouteArgs({this.key, required this.showTitle});

  final _i2.Key? key;

  final bool showTitle;
}

class WelcomeScreenRoute extends _i1.PageRouteInfo {
  const WelcomeScreenRoute() : super(name, path: '/welcome');

  static const String name = 'WelcomeScreenRoute';
}

class ObjectivesScreenRoute extends _i1.PageRouteInfo {
  const ObjectivesScreenRoute() : super(name, path: '/objectives');

  static const String name = 'ObjectivesScreenRoute';
}

class ProfileSetupScreenRoute
    extends _i1.PageRouteInfo<ProfileSetupScreenRouteArgs> {
  ProfileSetupScreenRoute({_i2.Key? key, required bool editMode})
      : super(name,
            path: '/profile-setup/:editMode?',
            args: ProfileSetupScreenRouteArgs(key: key, editMode: editMode),
            rawPathParams: {'editMode': editMode});

  static const String name = 'ProfileSetupScreenRoute';
}

class ProfileSetupScreenRouteArgs {
  const ProfileSetupScreenRouteArgs({this.key, required this.editMode});

  final _i2.Key? key;

  final bool editMode;
}

class ProfileExtraInfoScreenRoute
    extends _i1.PageRouteInfo<ProfileExtraInfoScreenRouteArgs> {
  ProfileExtraInfoScreenRoute({_i2.Key? key, required bool editMode})
      : super(name,
            path: '/profile-extra-info/:editMode?',
            args: ProfileExtraInfoScreenRouteArgs(key: key, editMode: editMode),
            rawPathParams: {'editMode': editMode});

  static const String name = 'ProfileExtraInfoScreenRoute';
}

class ProfileExtraInfoScreenRouteArgs {
  const ProfileExtraInfoScreenRouteArgs({this.key, required this.editMode});

  final _i2.Key? key;

  final bool editMode;
}

class PhoneVerificationScreenRoute extends _i1.PageRouteInfo {
  const PhoneVerificationScreenRoute() : super(name, path: '/phone-verify');

  static const String name = 'PhoneVerificationScreenRoute';
}

class AuthScreenRoute extends _i1.PageRouteInfo<AuthScreenRouteArgs> {
  AuthScreenRoute({_i2.Key? key, required String state})
      : super(name,
            path: '/auth/:state?',
            args: AuthScreenRouteArgs(key: key, state: state),
            rawPathParams: {'state': state});

  static const String name = 'AuthScreenRoute';
}

class AuthScreenRouteArgs {
  const AuthScreenRouteArgs({this.key, required this.state});

  final _i2.Key? key;

  final String state;
}

class PhoneScreenRoute extends _i1.PageRouteInfo<PhoneScreenRouteArgs> {
  PhoneScreenRoute({_i2.Key? key, required String state})
      : super(name,
            path: '/phone/:state?',
            args: PhoneScreenRouteArgs(key: key, state: state),
            rawPathParams: {'state': state});

  static const String name = 'PhoneScreenRoute';
}

class PhoneScreenRouteArgs {
  const PhoneScreenRouteArgs({this.key, required this.state});

  final _i2.Key? key;

  final String state;
}

class ForgotPasswordScreenRoute extends _i1.PageRouteInfo {
  const ForgotPasswordScreenRoute() : super(name, path: '/forgot-password');

  static const String name = 'ForgotPasswordScreenRoute';
}

class OnboardingScreenRoute
    extends _i1.PageRouteInfo<OnboardingScreenRouteArgs> {
  OnboardingScreenRoute({required String type})
      : super(name,
            path: '/onboarding/:type',
            args: OnboardingScreenRouteArgs(type: type),
            rawPathParams: {'type': type});

  static const String name = 'OnboardingScreenRoute';
}

class OnboardingScreenRouteArgs {
  const OnboardingScreenRouteArgs({required this.type});

  final String type;
}

class CreatePostScreenRoute extends _i1.PageRouteInfo {
  const CreatePostScreenRoute() : super(name, path: '/create-post');

  static const String name = 'CreatePostScreenRoute';
}

class ChatScreenRoute extends _i1.PageRouteInfo<ChatScreenRouteArgs> {
  ChatScreenRoute({_i2.Key? key, required String recieverId, String? groupId})
      : super(name,
            path: '/chat/user',
            args: ChatScreenRouteArgs(
                key: key, recieverId: recieverId, groupId: groupId));

  static const String name = 'ChatScreenRoute';
}

class ChatScreenRouteArgs {
  const ChatScreenRouteArgs({this.key, required this.recieverId, this.groupId});

  final _i2.Key? key;

  final String recieverId;

  final String? groupId;
}

class ChatSearchScreenRoute extends _i1.PageRouteInfo {
  const ChatSearchScreenRoute() : super(name, path: '/chat/search');

  static const String name = 'ChatSearchScreenRoute';
}

class VideoPlayerScreenRoute
    extends _i1.PageRouteInfo<VideoPlayerScreenRouteArgs> {
  VideoPlayerScreenRoute({required int videoId, _i2.Key? key})
      : super(name,
            path: '/video-player',
            args: VideoPlayerScreenRouteArgs(videoId: videoId, key: key));

  static const String name = 'VideoPlayerScreenRoute';
}

class VideoPlayerScreenRouteArgs {
  const VideoPlayerScreenRouteArgs({required this.videoId, this.key});

  final int videoId;

  final _i2.Key? key;
}

class NotificationsScreenRoute extends _i1.PageRouteInfo {
  const NotificationsScreenRoute() : super(name, path: '/notifications');

  static const String name = 'NotificationsScreenRoute';
}

class PostScreenRoute extends _i1.PageRouteInfo<PostScreenRouteArgs> {
  PostScreenRoute({_i2.Key? key, required int postId})
      : super(name,
            path: '/post', args: PostScreenRouteArgs(key: key, postId: postId));

  static const String name = 'PostScreenRoute';
}

class PostScreenRouteArgs {
  const PostScreenRouteArgs({this.key, required this.postId});

  final _i2.Key? key;

  final int postId;
}

class RegisterMeetingScreenRoute
    extends _i1.PageRouteInfo<RegisterMeetingScreenRouteArgs> {
  RegisterMeetingScreenRoute(
      {_i2.Key? key,
      required _i41.MeetingConfig config,
      required _i42.UserMeetingPreference preference,
      required List<_i43.MeetingObjective> objectives,
      required List<_i44.MeetingInterest> interests})
      : super(name,
            path: '/register-meeting',
            args: RegisterMeetingScreenRouteArgs(
                key: key,
                config: config,
                preference: preference,
                objectives: objectives,
                interests: interests));

  static const String name = 'RegisterMeetingScreenRoute';
}

class RegisterMeetingScreenRouteArgs {
  const RegisterMeetingScreenRouteArgs(
      {this.key,
      required this.config,
      required this.preference,
      required this.objectives,
      required this.interests});

  final _i2.Key? key;

  final _i41.MeetingConfig config;

  final _i42.UserMeetingPreference preference;

  final List<_i43.MeetingObjective> objectives;

  final List<_i44.MeetingInterest> interests;
}

class MeetingDetailScreenRoute
    extends _i1.PageRouteInfo<MeetingDetailScreenRouteArgs> {
  MeetingDetailScreenRoute({_i2.Key? key, required int meetingId})
      : super(name,
            path: '/meeting-detail',
            args: MeetingDetailScreenRouteArgs(key: key, meetingId: meetingId));

  static const String name = 'MeetingDetailScreenRoute';
}

class MeetingDetailScreenRouteArgs {
  const MeetingDetailScreenRouteArgs({this.key, required this.meetingId});

  final _i2.Key? key;

  final int meetingId;
}

class MeetingRequestDetailScreenRoute
    extends _i1.PageRouteInfo<MeetingRequestDetailScreenRouteArgs> {
  MeetingRequestDetailScreenRoute({_i2.Key? key, required int meetingId})
      : super(name,
            path: '/meeting-request-detail',
            args: MeetingRequestDetailScreenRouteArgs(
                key: key, meetingId: meetingId));

  static const String name = 'MeetingRequestDetailScreenRoute';
}

class MeetingRequestDetailScreenRouteArgs {
  const MeetingRequestDetailScreenRouteArgs(
      {this.key, required this.meetingId});

  final _i2.Key? key;

  final int meetingId;
}

class PackageDetailScreenRoute
    extends _i1.PageRouteInfo<PackageDetailScreenRouteArgs> {
  PackageDetailScreenRoute({_i2.Key? key, required int packageId})
      : super(name,
            path: '/package-detail',
            args: PackageDetailScreenRouteArgs(key: key, packageId: packageId));

  static const String name = 'PackageDetailScreenRoute';
}

class PackageDetailScreenRouteArgs {
  const PackageDetailScreenRouteArgs({this.key, required this.packageId});

  final _i2.Key? key;

  final int packageId;
}

class PackagePurchaseScreenRoute
    extends _i1.PageRouteInfo<PackagePurchaseScreenRouteArgs> {
  PackagePurchaseScreenRoute({_i2.Key? key, required _i45.Package package})
      : super(name,
            path: '/package-purchase',
            args: PackagePurchaseScreenRouteArgs(key: key, package: package));

  static const String name = 'PackagePurchaseScreenRoute';
}

class PackagePurchaseScreenRouteArgs {
  const PackagePurchaseScreenRouteArgs({this.key, required this.package});

  final _i2.Key? key;

  final _i45.Package package;
}

class PointsFaqScreenRoute extends _i1.PageRouteInfo {
  const PointsFaqScreenRoute() : super(name, path: '/points-faq');

  static const String name = 'PointsFaqScreenRoute';
}

class ConversationScreenRoute
    extends _i1.PageRouteInfo<ConversationScreenRouteArgs> {
  ConversationScreenRoute({int? id})
      : super(name,
            path: '/roundtable/:id',
            args: ConversationScreenRouteArgs(id: id),
            rawPathParams: {'id': id});

  static const String name = 'ConversationScreenRoute';
}

class ConversationScreenRouteArgs {
  const ConversationScreenRouteArgs({this.id});

  final int? id;
}

class SeriesScreenRoute extends _i1.PageRouteInfo<SeriesScreenRouteArgs> {
  SeriesScreenRoute({int? id})
      : super(name,
            path: '/series/:id',
            args: SeriesScreenRouteArgs(id: id),
            rawPathParams: {'id': id});

  static const String name = 'SeriesScreenRoute';
}

class SeriesScreenRouteArgs {
  const SeriesScreenRouteArgs({this.id});

  final int? id;
}

class CreateConversationScreenRoute
    extends _i1.PageRouteInfo<CreateConversationScreenRouteArgs> {
  CreateConversationScreenRoute(
      {_i2.Key? key,
      required _i46.Topic topic,
      required _i47.ConversationType type})
      : super(name,
            path: '/create-conversation',
            args: CreateConversationScreenRouteArgs(
                key: key, topic: topic, type: type));

  static const String name = 'CreateConversationScreenRoute';
}

class CreateConversationScreenRouteArgs {
  const CreateConversationScreenRouteArgs(
      {this.key, required this.topic, required this.type});

  final _i2.Key? key;

  final _i46.Topic topic;

  final _i47.ConversationType type;
}

class ProfileIntroScreenRoute
    extends _i1.PageRouteInfo<ProfileIntroScreenRouteArgs> {
  ProfileIntroScreenRoute({_i2.Key? key, required bool editMode})
      : super(name,
            path: '/profile-intro/:editMode?',
            args: ProfileIntroScreenRouteArgs(key: key, editMode: editMode),
            rawPathParams: {'editMode': editMode});

  static const String name = 'ProfileIntroScreenRoute';
}

class ProfileIntroScreenRouteArgs {
  const ProfileIntroScreenRouteArgs({this.key, required this.editMode});

  final _i2.Key? key;

  final bool editMode;
}

class ProfileBasicScreenRoute
    extends _i1.PageRouteInfo<ProfileBasicScreenRouteArgs> {
  ProfileBasicScreenRoute({_i2.Key? key, required bool editMode})
      : super(name,
            path: '/profile-basic/:editMode?',
            args: ProfileBasicScreenRouteArgs(key: key, editMode: editMode),
            rawPathParams: {'editMode': editMode});

  static const String name = 'ProfileBasicScreenRoute';
}

class ProfileBasicScreenRouteArgs {
  const ProfileBasicScreenRouteArgs({this.key, required this.editMode});

  final _i2.Key? key;

  final bool editMode;
}

class ProfileTagsScreenRoute
    extends _i1.PageRouteInfo<ProfileTagsScreenRouteArgs> {
  ProfileTagsScreenRoute({_i2.Key? key, required bool editMode})
      : super(name,
            path: '/profile-tags/:editMode?',
            args: ProfileTagsScreenRouteArgs(key: key, editMode: editMode),
            rawPathParams: {'editMode': editMode});

  static const String name = 'ProfileTagsScreenRoute';
}

class ProfileTagsScreenRouteArgs {
  const ProfileTagsScreenRouteArgs({this.key, required this.editMode});

  final _i2.Key? key;

  final bool editMode;
}

class ProfileImageScreenRoute
    extends _i1.PageRouteInfo<ProfileImageScreenRouteArgs> {
  ProfileImageScreenRoute({_i2.Key? key, required bool editMode})
      : super(name,
            path: '/profile-image/:editMode?',
            args: ProfileImageScreenRouteArgs(key: key, editMode: editMode),
            rawPathParams: {'editMode': editMode});

  static const String name = 'ProfileImageScreenRoute';
}

class ProfileImageScreenRouteArgs {
  const ProfileImageScreenRouteArgs({this.key, required this.editMode});

  final _i2.Key? key;

  final bool editMode;
}

class ProfileBioScreenRoute
    extends _i1.PageRouteInfo<ProfileBioScreenRouteArgs> {
  ProfileBioScreenRoute({_i2.Key? key, required bool editMode})
      : super(name,
            path: '/profile-bio/:editMode?',
            args: ProfileBioScreenRouteArgs(key: key, editMode: editMode),
            rawPathParams: {'editMode': editMode});

  static const String name = 'ProfileBioScreenRoute';
}

class ProfileBioScreenRouteArgs {
  const ProfileBioScreenRouteArgs({this.key, required this.editMode});

  final _i2.Key? key;

  final bool editMode;
}

class ProfileEmailScreenRoute
    extends _i1.PageRouteInfo<ProfileEmailScreenRouteArgs> {
  ProfileEmailScreenRoute({_i2.Key? key, required bool editMode})
      : super(name,
            path: '/profile-email/:editMode?',
            args: ProfileEmailScreenRouteArgs(key: key, editMode: editMode),
            rawPathParams: {'editMode': editMode});

  static const String name = 'ProfileEmailScreenRoute';
}

class ProfileEmailScreenRouteArgs {
  const ProfileEmailScreenRouteArgs({this.key, required this.editMode});

  final _i2.Key? key;

  final bool editMode;
}

class ProfileRequestScreenRoute
    extends _i1.PageRouteInfo<ProfileRequestScreenRouteArgs> {
  ProfileRequestScreenRoute({_i2.Key? key, required bool editMode})
      : super(name,
            path: '/profile-request-settings/:editMode?',
            args: ProfileRequestScreenRouteArgs(key: key, editMode: editMode),
            rawPathParams: {'editMode': editMode});

  static const String name = 'ProfileRequestScreenRoute';
}

class ProfileRequestScreenRouteArgs {
  const ProfileRequestScreenRouteArgs({this.key, required this.editMode});

  final _i2.Key? key;

  final bool editMode;
}

class NewPasswordScreenRoute
    extends _i1.PageRouteInfo<NewPasswordScreenRouteArgs> {
  NewPasswordScreenRoute({_i2.Key? key, String? params})
      : super(name,
            path: '/new-password/:params?',
            args: NewPasswordScreenRouteArgs(key: key, params: params),
            rawPathParams: {'params': params});

  static const String name = 'NewPasswordScreenRoute';
}

class NewPasswordScreenRouteArgs {
  const NewPasswordScreenRouteArgs({this.key, this.params});

  final _i2.Key? key;

  final String? params;
}

class ProfileScreenRoute extends _i1.PageRouteInfo<ProfileScreenRouteArgs> {
  ProfileScreenRoute(
      {required String userId, int? createrId, required bool allowEdit})
      : super(name,
            path: '/profile-detail/:userId/:allowEdit',
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
}

class PastStreamScreenRoute
    extends _i1.PageRouteInfo<PastStreamScreenRouteArgs> {
  PastStreamScreenRoute({int? id})
      : super(name,
            path: '/past-stream/:id',
            args: PastStreamScreenRouteArgs(id: id),
            rawPathParams: {'id': id});

  static const String name = 'PastStreamScreenRoute';
}

class PastStreamScreenRouteArgs {
  const PastStreamScreenRouteArgs({this.id});

  final int? id;
}
