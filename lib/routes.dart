import 'package:auto_route/annotations.dart';

import 'core/widgets/screens/home_screen/home_screen.dart';
import 'features/auth/presentation/screens/auth/auth_screen.dart';
import 'features/auth/presentation/screens/forgot_password/forgot_password_screen.dart';
import 'features/auth/presentation/screens/new_password/new_password_screen.dart';
import 'features/auth/presentation/screens/onboarding/onboarding_screen.dart';
import 'features/auth/presentation/screens/splash/splash_screen.dart';
import 'features/auth/presentation/screens/welcome/welcome_screen.dart';
import 'features/chat/presentation/screens/chat_screen.dart';
import 'features/chat_inbox/presentation/screens/chat_search_screen.dart';
import 'features/community/presentation/screens/create_post.dart';
import 'features/community/presentation/screens/post_screen.dart';
import 'features/conversations/presentation/screens/conversation_screen_2/conversation_screen.dart';
import 'features/conversations/presentation/screens/create_conversation_screen/create_conversation_screen.dart';
import 'features/meeting/presentation/screens/meeting_details_screen.dart';
import 'features/meeting/presentation/screens/register_meeting_screen.dart';
import 'features/notification/presentation/screens/notifications_screen.dart';
import 'features/points/presentation/screens/points_faq_screen.dart';
import 'features/profile/presentation/screens/profile_screen/profile_screen.dart';
import 'features/rewards/presentation/screens/package_detail_screen.dart';
import 'features/rewards/presentation/screens/package_purchase_screen.dart';
import 'features/signup/presentation/screens/objectives_screen.dart';
import 'features/signup/presentation/screens/phone_verification_screen.dart';
import 'features/signup/presentation/screens/profile_basic_screen.dart';
import 'features/signup/presentation/screens/profile_bio_screen.dart';
import 'features/signup/presentation/screens/profile_extra_info_screen/profile_intro_screen.dart';
import 'features/signup/presentation/screens/profile_image_screen.dart';
import 'features/signup/presentation/screens/profile_intro_screen.dart';
import 'features/signup/presentation/screens/profile_setup_screen.dart';
import 'features/signup/presentation/screens/profile_tags_screen.dart';
import 'features/videos/presentation/screens/video_player_screen.dart';

@MaterialAutoRouter(
  preferRelativeImports: true,
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: SplashScreen, initial: true),
    AutoRoute(page: HomeScreen, path: "/home/:tab?"),
    AutoRoute(
        page: HomeScreen, path: "/topic-list/:topic?", name: "topicListScreen"),
    AutoRoute(page: WelcomeScreen, path: "/welcome"),
    AutoRoute(page: ObjectivesScreen, path: "/objectives/:editMode?"),
    AutoRoute(page: ProfileSetupScreen, path: "/profile-setup/:editMode?"),
    AutoRoute(page: ProfileExtraInfoScreen, path: "/profile-extra-info"),
    AutoRoute(page: PhoneVerificationScreen, path: "/phone-verify"),
    AutoRoute(page: AuthScreen, path: "/auth/:state?"),
    AutoRoute(page: ForgotPasswordScreen, path: "/forgot-password"),
    AutoRoute(page: OnboardingScreen, path: "/onboarding/:type"),
    AutoRoute(
        page: CreatePostScreen, path: "/create-post", fullscreenDialog: true),
    AutoRoute(page: ChatScreen, path: "/chat/user"),
    AutoRoute(page: ChatSearchScreen, path: "/chat/search"),
    AutoRoute(page: VideoPlayerScreen, path: "/video-player"),
    AutoRoute(page: NotificationsScreen, path: "/notifications"),
    AutoRoute(page: PostScreen, path: "/post"),
    AutoRoute(page: RegisterMeetingScreen, path: "/register-meeting"),
    AutoRoute(page: MeetingDetailScreen, path: "/meeting-detail"),
    AutoRoute(page: PackageDetailScreen, path: "/package-detail"),
    AutoRoute(page: PackagePurchaseScreen, path: "/package-purchase"),
    AutoRoute(page: PointsFaqScreen, path: "/points-faq"),
    AutoRoute(page: ConversationScreen, path: "/roundtable/:id"),
    AutoRoute(page: CreateConversationScreen, path: "/create-conversation"),
    AutoRoute(page: ProfileIntroScreen, path: "/profile-intro/:editMode?"),
    AutoRoute(page: ProfileBasicScreen, path: "/profile-basic/:editMode?"),
    AutoRoute(page: ProfileTagsScreen, path: "/profile-tags/:editMode?"),
    AutoRoute(page: ProfileImageScreen, path: "/profile-image/:editMode?"),
    AutoRoute(page: ProfileBioScreen, path: "/profile-bio/:editMode?"),
    AutoRoute(page: NewPasswordScreen, path: "/new-password/:params?"),
    AutoRoute(page: ProfileScreen, path: "/profile-detail/:userId/:allowEdit"),
  ],
)
class $AppRouter {}
