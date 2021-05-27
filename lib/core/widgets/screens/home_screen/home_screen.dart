import 'package:auto_route/auto_route.dart';
import 'package:auto_route/auto_route_annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/constants/app_constants.dart';

import '../../../../constants/theme.dart';
import '../../../../constants/work_net_icons_icons.dart';
import '../../../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../../../features/auth/presentation/screens/onboarding/onboarding_screen_state.dart';
import '../../../../features/auth/presentation/widgets/user_profile_nav_item/user_profile_nav_item.dart';
import '../../../../features/conversations/presentation/widgets/conversation_calendar_tab/conversation_calendar_tab.dart';
import '../../../../features/conversations/presentation/widgets/conversation_calendar_tab/conversation_calendar_tab_state.dart';
import '../../../../features/conversations/presentation/widgets/topics_tab/topics_tab.dart';
import '../../../../routes.gr.dart';
import '../../../../ui/components/app_drawer/app_drawer.dart';
import '../../../features/share_manager/share_manager.dart';
import '../../base/base_container/base_container.dart';
import 'home_tab_controller_provider.dart';

final homeScreenScrollController =
    Provider.autoDispose<ScrollController>((ref) {
  final controller = ScrollController();
  ref.onDispose(() {
    controller.dispose();
  });
  return controller;
});

class HomeScreen extends HookWidget {
  final int tab;

  static const icons = [
    Icons.search,
    Icons.people_alt_outlined,
    Icons.inbox_outlined
  ];

  static const labels = [
    'Topics',
    'Conversations',
    'My Conversations',
  ];

  const HomeScreen({
    @PathParam() this.tab,
  });

  @override
  Widget build(BuildContext context) {
    final _scrollController = useProvider(homeScreenScrollController);
    final shareManager = useProvider(shareManagerProvider);
    final _tabController =
        useTabController(initialLength: labels.length, initialIndex: tab ?? 0);

    final _activeTab = useState(tab ?? 0);

    final name =
        BlocProvider.of<AuthBloc>(context).state.user.name.split(' ').first;

    useEffect(() {
      void _tabChangeListener() {
        if (!_tabController.indexIsChanging) {
          _activeTab.value = _tabController.index;
        }
      }

      _tabController.addListener(_tabChangeListener);

      _navigateToHome(context);

      return () {
        _tabController.removeListener(_tabChangeListener);
      };
    });

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      drawer: AppDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabController.index,
        iconSize: 28,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        items: [0, 1, 2]
            .map((index) => BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BaseContainer(
                    radius: 30,
                    color: Theme.of(context).backgroundColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(icons[index]),
                    ),
                  ),
                ),
                label: labels[index]))
            .toList(),
        onTap: (int index) {
          _tabController.index = index;
        },
      ),
      body: SafeArea(
        child: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  floating: true,
                  // pinned: true,
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BaseContainer(
                      radius: 30,
                      color: Theme.of(context).backgroundColor,
                      child: IconButton(
                          icon: const Icon(
                            WorkNetIcons.menu,
                          ),
                          onPressed: () => Scaffold.of(context).openDrawer()),
                    ),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: BaseContainer(
                        color: Theme.of(context).backgroundColor,
                        radius: 30,
                        child: IconButton(
                          icon: SvgPicture.asset(
                            AppSvgAssets.share,
                          ),
                          onPressed: () => shareManager.share(context),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppInsets.sm),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: BaseContainer(
                        color: Theme.of(context).backgroundColor,
                        radius: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: UserProfileNavItem(
                            onPressed: () {
                              final user = BlocProvider.of<AuthBloc>(context)
                                  .state
                                  ?.user;
                              if (user != null) {
                                ExtendedNavigator.of(context).push(
                                    Routes.profileScreen(
                                        userId: user.pk, allowEdit: true));
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppInsets.l),
                  ],
                ),
              ),
            ];
          },
          body: DefaultStickyHeaderController(
            child: HomeTabControllerProvider(
              controller: _tabController,
              child: TabBarView(
                controller: _tabController,
                children: [
                  TopicsTab(name: name),
                  ConversationCalendarTab(
                    type: ConversationTabType.all,
                    controller: _scrollController,
                    name: name,
                    onSchedulePressed: () => _tabController.animateTo(0),
                  ),
                  ConversationCalendarTab(
                    type: ConversationTabType.my,
                    controller: _scrollController,
                    name: name,
                    onSchedulePressed: () => _tabController.animateTo(0),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _navigateToHome(BuildContext context) async {
    final onboarding = ProviderContainer().read(onboardingProvider);

    final shown = await onboarding.getOnboardingKey();

    if (!shown) {
      ExtendedNavigator.of(context)
          .pushAndRemoveUntil(Routes.onboardingScreen, (_) => false);
    }
  }
}
