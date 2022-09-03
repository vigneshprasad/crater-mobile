import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/core/features/socket_io/socket_io_manager.dart';
import 'package:worknetwork/core/push_notfications/push_notifications.dart';
import 'package:worknetwork/core/widgets/components/home_tab_bar/home_tab_bar.dart';
import 'package:worknetwork/core/widgets/screens/home_screen/home_tab_controller_provider.dart';
import 'package:worknetwork/features/auth/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:worknetwork/features/auth/presentation/screens/onboarding/onboarding_screen_state.dart';
import 'package:worknetwork/features/auth/presentation/screens/splash/splash_screen_state.dart';
import 'package:worknetwork/features/club/presentation/screens/streams/past_stream_screen.dart';
import 'package:worknetwork/features/club/presentation/screens/streams/stream_screen.dart';
import 'package:worknetwork/features/connection/presentation/screen/connection_tab/connection_tab.dart';
import 'package:worknetwork/features/hub/presentation/screen/hub_screen.dart';
import 'package:worknetwork/features/profile/presentation/screens/profile_screen/profile_screen.dart';
import 'package:worknetwork/routes.gr.dart';

class HomeScreen extends HookConsumerWidget {
  final int? tab;

  const HomeScreen({@PathParam() this.tab = 0});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const tabCount = 3;

    final user = ref.read(authStateProvider.notifier).getUser();

    final _tabController =
        useTabController(initialLength: tabCount, initialIndex: tab ?? 0);

    final _activeTab = useState(tab ?? 0);

    useEffect(() {
      void _tabChangeListener() {
        if (!_tabController.indexIsChanging) {
          _activeTab.value = _tabController.index;
        }
      }

      _tabController.addListener(_tabChangeListener);

      _navigateToHome(context);

      ref.read(pushNotificationsProvider).promptForPermission();

      return () {
        _tabController.removeListener(_tabChangeListener);
      };
    });

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      // drawer: AppDrawer(),
      bottomNavigationBar: HomeTabBar(tabController: _tabController),
      body: HomeTabControllerProvider(
        controller: _tabController,
        child: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: [
            StreamTab(),
            const PastStreamScreen(),
            // ConnectionTab(),
            // const HubScreen(),
            ProfileScreen(user?.pk ?? '', allowEdit: true)
          ],
        ),
      ),
    );
  }

  Future<void> _navigateToHome(BuildContext context) async {
    final onboarding = ProviderContainer().read(onboardingProvider);

    final shown = await onboarding.getOnboardingKey();

    if (!shown) {
      AutoRouter.of(context).pushAndPopUntil(
        OnboardingScreenRoute(type: OnboardingType.signupComplete.toString()),
        predicate: (_) => false,
      );
    }
  }
}
