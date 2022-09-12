import 'package:auto_route/annotations.dart';
import 'package:worknetwork/core/widgets/screens/home_screen/home_screen.dart';
import 'package:worknetwork/features/auth/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:worknetwork/features/auth/presentation/screens/phone/otp_screen.dart';
import 'package:worknetwork/features/auth/presentation/screens/phone/phone_screen.dart';
import 'package:worknetwork/features/auth/presentation/screens/splash/splash_screen.dart';
import 'package:worknetwork/features/auth/presentation/screens/welcome/welcome_screen.dart';
import 'package:worknetwork/features/chat/presentation/screens/chat_screen.dart';
import 'package:worknetwork/features/club/presentation/screens/past_stream/past_stream_detail_screen.dart';
import 'package:worknetwork/features/club/presentation/screens/streams/past_stream_screen.dart';
import 'package:worknetwork/features/club/presentation/screens/streams/upcoming_stream_screen.dart';
import 'package:worknetwork/features/conversations/presentation/screens/conversation_screen/conversation_screen.dart';
import 'package:worknetwork/features/conversations/presentation/screens/series_screen/series_screen.dart';
import 'package:worknetwork/features/profile/presentation/screens/profile_screen/profile_screen.dart';
import 'package:worknetwork/features/signup/presentation/screens/profile_basic_screen.dart';
import 'package:worknetwork/features/signup/presentation/screens/profile_email_screen.dart';

@MaterialAutoRouter(
  preferRelativeImports: true,
  routes: <AutoRoute>[
    AutoRoute(page: SplashScreen, initial: true, path: "/"),
    AutoRoute(page: HomeScreen, path: "/home/:tab?"),
    AutoRoute(page: WelcomeScreen, path: "/welcome"),
    AutoRoute(page: PhoneScreen, path: "/phone/:state?"),
    AutoRoute(page: OTPScreen, path: "/otp/:state?"),
    AutoRoute(page: OnboardingScreen, path: "/onboarding/:type"),
    AutoRoute(page: ChatScreen, path: "/chat/user"),
    AutoRoute(page: ConversationScreen, path: "/roundtable/:id"),
    AutoRoute(page: SeriesScreen, path: "/series/:id"),
    AutoRoute(page: ProfileBasicScreen, path: "/profile-basic/:editMode?"),
    AutoRoute(page: ProfileEmailScreen, path: "/profile-email/:editMode?"),
    AutoRoute(
      page: ProfileScreen,
      path: "/profile-detail/:userId/:createrId?/:allowEdit",
    ),
    AutoRoute(page: PastStreamDetailScreen, path: "/past-stream/:id"),
    AutoRoute(page: PastStreamScreen, path: "/past-streams/:categoryId?"),
    AutoRoute(page: UpcomingStreamScreen, path: "/upcoming-streams"),
  ],
)
class $AppRouter {}
