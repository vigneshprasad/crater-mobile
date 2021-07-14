import 'package:auto_route/auto_route.dart';
import 'package:auto_route/auto_route_annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide ReadContext;
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
import '../../../../features/conversations/presentation/widgets/connection_tab/connection_tab.dart';
import '../../../../features/conversations/presentation/widgets/conversation_calendar_tab/conversation_calendar_tab.dart';
import '../../../../features/conversations/presentation/widgets/conversation_calendar_tab/conversation_calendar_tab_state.dart';
import '../../../../features/conversations/presentation/widgets/topics_tab/topics_tab.dart';
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
  final int tab;
  final int topic;

  static const icons = [
    Icons.home,
    Icons.people_alt,
    null,
    Icons.inbox,
    Icons.search,
  ];

  static const labels = [
    'Topics',
    'Conversations',
    '',
    'My',
    'Community',
  ];

  static const analyticsLabels = [
    "topics_tab_viewed",
    "all_conversations_tab_viewed",
    'create_conversations_tab_viewed',
    "my_conversations_tab_viewed",
    'community_tab_viewed',
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

    final name =
        BlocProvider.of<AuthBloc>(context).state.user.name.split(' ').first;
    final email = BlocProvider.of<AuthBloc>(context).state.user.email;

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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      drawer: AppDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final value = await _startConversation(context);
          if (value == null) {
            return;
          }
          _tabController.animateTo(0);
          _activeTopic.value = value;
        },
        backgroundColor: Colors.black,
        foregroundColor: HexColor.fromHex("#72675B"),
        tooltip: 'Create a Conversation',
        elevation: 4.0,
        child: const Icon(Icons.add, size: 36),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BaseContainer(
        radius: 0,
        disableAnimation: true,
        child: BottomNavigationBar(
          currentIndex: _tabController.index,
          iconSize: 28,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          unselectedItemColor: HexColor.fromHex("#72675B"),
          type: BottomNavigationBarType.fixed,
          items: [0, 1, 2, 3, 4]
              .map((index) => BottomNavigationBarItem(
                  icon: Icon(
                    icons[index],
                  ),
                  label: labels[index]))
              .toList(),
          onTap: (int index) {
            if (index == 2) {
              return;
            }

            _tabController.index = index;
          },
        ),
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
                      color: Theme.of(context).backgroundColor,
                      radius: 30,
                      child: IconButton(
                        icon: const Icon(Icons.help),
                        onPressed: () =>
                            context.read(intercomProvider).show(email),
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
                  TopicsTab(name: name, topic: _activeTopic),
                  ConversationCalendarTab(
                    type: ConversationTabType.all,
                    controller: _scrollController,
                    name: name,
                    onSchedulePressed: () => _tabController.animateTo(0),
                  ),
                  Container(),
                  ConversationCalendarTab(
                    type: ConversationTabType.my,
                    controller: _scrollController,
                    name: name,
                    onSchedulePressed: () => _tabController.animateTo(0),
                  ),
                  ConnectionTab(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<int> _startConversation(BuildContext context) {
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
                              child: Text('1:1'),
                              onPressed: () {
                                Navigator.of(context).pop(0);
                              },
                            ),
                          ),
                        ),
                        BaseContainer(
                          child: SizedBox(
                            width: 80,
                            height: 80,
                            child: BaseLargeButton(
                              child: Text('AMA'),
                              onPressed: () {
                                Navigator.of(context).pop(1);
                              },
                            ),
                          ),
                        ),
                        BaseContainer(
                          child: SizedBox(
                            width: 80,
                            height: 80,
                            child: BaseLargeButton(
                              child: Text(
                                'Round\nTable',
                                textAlign: TextAlign.center,
                              ),
                              onPressed: () {
                                Navigator.of(context).pop(2);
                              },
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

  Future<void> _navigateToHome(BuildContext context) async {
    final onboarding = ProviderContainer().read(onboardingProvider);

    final shown = await onboarding.getOnboardingKey();

    if (!shown) {
      ExtendedNavigator.of(context).pushAndRemoveUntil(
          Routes.onboardingScreen(type: OnboardingType.signupComplete),
          (_) => false);
    }
  }
}
