import 'package:auto_route/auto_route_annotations.dart';

import 'core/widgets/screens/home_screen.dart';
import 'features/auth/presentation/screens/auth/auth_screen.dart';
import 'features/auth/presentation/screens/forgot_password/forgot_password_screen.dart';
import 'features/auth/presentation/screens/splash/splash_screen.dart';
import 'features/chat/presentation/screens/chat_screen.dart';
import 'features/chat_inbox/presentation/screens/chat_search_screen.dart';
import 'features/community/presentation/screens/create_post.dart';
import 'features/community/presentation/screens/post_screen.dart';
import 'features/meeting/presentation/screens/meeting_details_screen.dart';
import 'features/meeting/presentation/screens/register_meeting_screen.dart';
import 'features/notification/presentation/screens/notifications_screen.dart';
import 'features/points/presentation/screens/points_faq_screen.dart';
import 'features/rewards/presentation/screens/package_detail_screen.dart';
import 'features/rewards/presentation/screens/package_purchase_screen.dart';
import 'features/roundtable/presentation/screens/roundtable_screen/roundtable_screen.dart';
import 'features/signup/presentation/screens/objectives_screen.dart';
import 'features/signup/presentation/screens/phone_verification_screen.dart';
import 'features/signup/presentation/screens/profile_setup_screen.dart';
import 'features/videos/presentation/screens/video_player_screen.dart';

@MaterialAutoRouter(
  generateNavigationHelperExtension: true,
  routes: <AutoRoute>[
    MaterialRoute(page: SplashScreen, initial: true),
    MaterialRoute(page: HomeScreen, path: "/home/:tab?"),
    MaterialRoute(page: ObjectivesScreen, path: "/objectives"),
    MaterialRoute(page: ProfileSetupScreen, path: "/profile-setup"),
    MaterialRoute(page: PhoneVerificationScreen, path: "/phone-verify"),
    MaterialRoute(page: AuthScreen, path: "/auth"),
    MaterialRoute(page: ForgotPasswordScreen, path: "/forgot-password"),
    MaterialRoute(
        page: CreatePostScreen, path: "/create-post", fullscreenDialog: true),
    MaterialRoute(page: ChatScreen, path: "/chat/user"),
    MaterialRoute(page: ChatSearchScreen, path: "/chat/search"),
    MaterialRoute(page: VideoPlayerScreen, path: "/video-player"),
    MaterialRoute(page: NotificationsScreen, path: "/notifications"),
    MaterialRoute(page: PostScreen, path: "/post"),
    MaterialRoute(page: RegisterMeetingScreen, path: "/register-meeting"),
    MaterialRoute(page: MeetingDetailScreen, path: "/meeting-detail"),
    MaterialRoute(page: PackageDetailScreen, path: "/package-detail"),
    MaterialRoute(page: PackagePurchaseScreen, path: "/package-purchase"),
    MaterialRoute(page: PointsFaqScreen, path: "/points-faq"),
    MaterialRoute(page: RoundTableScreen, path: "/roundtable/:id")
  ],
)
class $Router {}
