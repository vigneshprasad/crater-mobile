import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide ReadContext;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kiwi/kiwi.dart';
import 'package:worknetwork/core/widgets/components/home_tab_bar/home_tab_bar.dart';
import 'package:worknetwork/features/connection/presentation/screen/connection_tab/connection_tab.dart';

import '../../../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../../../features/auth/presentation/screens/onboarding/onboarding_screen.dart';
import '../../../../features/auth/presentation/screens/onboarding/onboarding_screen_state.dart';
import '../../../../features/club/presentation/screens/streams/stream_screen.dart';
import '../../../../features/conversations/presentation/widgets/conversation_calendar_tab/conversation_calendar_tab.dart';
import '../../../../features/conversations/presentation/widgets/conversation_calendar_tab/conversation_calendar_tab_state.dart';
import '../../../../features/profile/presentation/screens/profile_screen/profile_screen.dart';
import '../../../../routes.gr.dart';
import '../../../analytics/analytics.dart';
import 'home_tab_controller_provider.dart';

class HomeScreen extends HookWidget {
  final int? tab;

  static const analyticsLabels = [
    "all_conversations_tab_viewed",
    'community_tab_viewed',
    "my_conversations_tab_viewed",
    "profile_tab_viewed",
  ];

  static const tabCount = 4;

  const HomeScreen({@PathParam() this.tab = 0});

  @override
  Widget build(BuildContext context) {
    final _tabController =
        useTabController(initialLength: tabCount, initialIndex: tab ?? 0);

    final _activeTab = useState(tab ?? 0);

    final user = BlocProvider.of<AuthBloc>(context).state.user;
    final name = user?.name?.split(' ').first ?? '';

    useEffect(() {
      void _tabChangeListener() {
        if (!_tabController.indexIsChanging) {
          _activeTab.value = _tabController.index;
          KiwiContainer()
              .resolve<Analytics>()
              .trackEvent(eventName: analyticsLabels[_activeTab.value]);
        }
      }

      _tabController.addListener(_tabChangeListener);

      _navigateToHome(context);

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
            ConnectionTab(),
            ConversationCalendarTab(
              type: ConversationTabType.my,
              name: name,
              onSchedulePressed: () {
                AutoRouter.of(context).push(TopicsListRoute(showTitle: true));
              },
            ),
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
          predicate: (_) => false);
    }
  }
}
