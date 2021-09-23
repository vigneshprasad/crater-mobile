import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide ReadContext;
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kiwi/kiwi.dart';

import '../../../../constants/app_constants.dart';
import '../../../../constants/theme.dart';
import '../../../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../../../features/auth/presentation/screens/onboarding/onboarding_screen.dart';
import '../../../../features/auth/presentation/screens/onboarding/onboarding_screen_state.dart';
import '../../../../features/auth/presentation/widgets/user_profile_nav_item/user_profile_nav_item.dart';
import '../../../../features/club/presentation/screens/clubs/clubs_screen.dart';
import '../../../../features/conversations/presentation/widgets/connection_tab/connection_tab.dart';
import '../../../../features/conversations/presentation/widgets/conversation_calendar_tab/conversation_calendar_tab.dart';
import '../../../../features/conversations/presentation/widgets/conversation_calendar_tab/conversation_calendar_tab_state.dart';
import '../../../../features/profile/presentation/screens/profile_screen/gradient_button.dart';
import '../../../../features/profile/presentation/screens/profile_screen/profile_screen.dart';
import '../../../../routes.gr.dart';
import '../../../../ui/components/app_drawer/app_drawer.dart';
import '../../../analytics/analytics.dart';
import '../../../color/color.dart';
import '../../../features/share_manager/share_manager.dart';
import '../../../integrations/intercom/intercom_provider.dart';
import '../../base/base_container/base_container.dart';
import '../../base/base_large_button/base_large_button.dart';
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
  final int? tab;
  final int? topic;

  static const icons = [
    Icon(Icons.search),
    Icon(Icons.inbox),
    Icon(Icons.people_alt),
    UserProfileNavItem(),
  ];

  static const labels = [
    'Community',
    'My Conversations',
    'Clubs',
    'Profile',
  ];

  static const analyticsLabels = [
    'community_tab_viewed',
    "my_conversations_tab_viewed",
    "all_conversations_tab_viewed",
    "profile_tab_viewed",
  ];

  const HomeScreen({
    @PathParam() this.tab = 0,
    @PathParam() this.topic = 0,
  });

  @override
  Widget build(BuildContext context) {
    final _scrollController = useProvider(homeScreenScrollController);
    final shareManager = useProvider(shareManagerProvider);
    final _tabController =
        useTabController(initialLength: labels.length, initialIndex: tab ?? 0);

    final _activeTab = useState(tab ?? 0);
    final _activeTopic = useState(topic ?? 0);

    final user = BlocProvider.of<AuthBloc>(context).state.user;
    final name = user?.name?.split(' ').first ?? '';
    final email = user?.email;

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
      drawer: AppDrawer(),
      bottomNavigationBar: BaseContainer(
        radius: 0,
        disableAnimation: true,
        child: BottomNavigationBar(
          currentIndex: _tabController.index,
          iconSize: 28,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          type: BottomNavigationBarType.fixed,
          items: [0, 1, 2, 3]
              .map((index) => BottomNavigationBarItem(
                    icon: icons[index],
                    label: labels[index],
                  ))
              .toList(),
          onTap: (int index) {
            _tabController.index = index;
          },
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                    sliver: SliverAppBar(
                      floating: true,
                      title: _activeTab.value != 2
                          ? null
                          : const UnderlinedText('STREAMS'),
                      centerTitle: true,
                      // pinned: true,
                      leading: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: BaseContainer(
                          color: Theme.of(context).backgroundColor,
                          radius: 30,
                          child: IconButton(
                            icon: const Icon(Icons.help),
                            onPressed: () =>
                                context.read(intercomProvider).show(email!),
                          ),
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
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _tabController,
                    children: [
                      ConnectionTab(),
                      ConversationCalendarTab(
                        type: ConversationTabType.my,
                        controller: _scrollController,
                        name: name,
                        onSchedulePressed: () {
                          AutoRouter.of(context)
                              .push(TopicsListRoute(showTitle: true));
                        },
                      ),
                      ClubsScreen(),
                      ProfileScreen(user?.pk ?? '', allowEdit: true)
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: floatingButton(_activeTab.value, context),
            ),
          ],
        ),
      ),
    );
  }

  Widget floatingButton(int acticeTab, BuildContext context) {
    switch (acticeTab) {
      case 0:
        return matchMeButton(context);
      // case 2:
      //   return earlyAccessButton(context);
      default:
        return Container();
    }
  }

  FloatingActionButtonLocation floatingButtonLocation(int acticeTab) {
    switch (acticeTab) {
      case 2:
        return FloatingActionButtonLocation.centerFloat;
      default:
        return FloatingActionButtonLocation.endFloat;
    }
  }

  Container matchMeButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            HexColor.fromHex('#3C3B3B'),
            HexColor.fromHex('#4E4E4E'),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      width: double.infinity,
      child: Row(
        children: [
          const Text(
            'Worknetwork\nIntelligence',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          GradientButton(
            title: 'MATCH ME',
            onPressed: () async {
              // await showModalBottomSheet(
              //   elevation: 10,
              //   backgroundColor: Colors.transparent,
              //   context: context,
              //   isDismissible: false,
              //   enableDrag: false,
              //   useRootNavigator: false,
              //   builder: (context) {
              //     return const ProfileEmailScreen(editMode: true);
              //   },
              // );
              // return;
              AutoRouter.of(context).push(TopicsListRoute(showTitle: true));
            },
          ),
        ],
      ),
    );
  }

  Container earlyAccessButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            HexColor.fromHex('#3C3B3B'),
            HexColor.fromHex('#4E4E4E'),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      width: double.infinity,
      child: Row(
        children: [
          const Text(
            'For mentors\n& creators',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          GradientButton(
            title: 'EARLY ACCESS',
            onPressed: () async {
              final user = BlocProvider.of<AuthBloc>(context).state.user;
              final email = user?.email;
              final url =
                  'https://worknetwork.typeform.com/to/DXvutVaB#email=$email';
              await launch(
                url,
                customTabsOption: const CustomTabsOption(
                  enableUrlBarHiding: true,
                  extraCustomTabs: [],
                  showPageTitle: false,
                  enableInstantApps: false,
                ),
              );
            },
          ),
        ],
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

Future<int?> startConversation(BuildContext context) {
  return showModalBottomSheet(
      elevation: 10,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppBorderRadius.bottomSheetRadius),
              topRight: Radius.circular(AppBorderRadius.bottomSheetRadius),
            ),
            child: Container(
              color: Theme.of(context).backgroundColor,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 30,
                    runSpacing: 30,
                    children: [
                      Text(
                        'Start a conversation',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text(
                        'What type of conversation would you like to have?',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.caption,
                      ),
                      BaseContainer(
                        child: SizedBox(
                          width: 80,
                          height: 80,
                          child: BaseLargeButton(
                            onPressed: () {
                              Navigator.of(context).pop(0);
                            },
                            child: const Text('1:1'),
                          ),
                        ),
                      ),
                      BaseContainer(
                        child: SizedBox(
                          width: 80,
                          height: 80,
                          child: BaseLargeButton(
                            onPressed: () {
                              Navigator.of(context).pop(1);
                            },
                            child: const Text('AMA'),
                          ),
                        ),
                      ),
                      BaseContainer(
                        child: SizedBox(
                          width: 80,
                          height: 80,
                          child: BaseLargeButton(
                            onPressed: () {
                              Navigator.of(context).pop(2);
                            },
                            child: const Text(
                              'Round\nTable',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
      });
}
