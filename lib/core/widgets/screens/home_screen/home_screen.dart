import 'package:auto_route/auto_route.dart';
import 'package:auto_route/auto_route_annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../constants/theme.dart';
import '../../../../features/article/presentation/widgets/articles_tab.dart';
import '../../../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../../../features/auth/presentation/widgets/user_profile_nav_item/user_profile_nav_item.dart';
import '../../../../features/chat_inbox/presentation/widgets/inbox_tab.dart';
import '../../../../features/conversations/domain/entity/optin_entity/optin_entity.dart';
import '../../../../features/conversations/domain/entity/topic_entity/topic_entity.dart';
import '../../../../features/conversations/presentation/screens/create_conversation_sheet/create_conversation_sheet.dart';
import '../../../../features/conversations/presentation/widgets/conversation_calendar_tab/conversation_calendar_tab.dart';
import '../../../../features/conversations/presentation/widgets/conversation_calendar_tab/conversation_calendar_tab_state.dart';
import '../../../../routes.gr.dart';
import '../../components/home_tab_bar/home_tab_bar.dart';

final homeScreenScrollController =
    Provider.autoDispose<ScrollController>((ref) {
  final controller = ScrollController();
  ref.onDispose(() {
    controller.dispose();
  });
  return controller;
});

class HomeScreen extends HookWidget {
  final String tab;

  static const List<Widget> _tabs = [
    Tab(text: "All Conversation"),
    Tab(text: "My Conversation"),
    Tab(text: "Inbox"),
    Tab(text: "Articles"),
  ];

  const HomeScreen({
    @PathParam() this.tab,
  });

  @override
  Widget build(BuildContext context) {
    final _scrollController = useProvider(homeScreenScrollController);
    final _tabController = useTabController(initialLength: _tabs.length);
    final labelStyle = Theme.of(context).textTheme.bodyText1.copyWith(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Colors.grey[800],
        );
    final _activeTab = useState(0);

    useEffect(() {
      void _tabChangeListener() {
        if (!_tabController.indexIsChanging) {
          _activeTab.value = _tabController.index;
        }
      }

      _tabController.addListener(_tabChangeListener);

      return () {
        _tabController.removeListener(_tabChangeListener);
      };
    });

    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                expandedHeight: 120.00,
                floating: true,
                pinned: true,
                elevation: 0,
                actions: [
                  UserProfileNavItem(
                    onPressed: () {
                      final user =
                          BlocProvider.of<AuthBloc>(context).state?.user;
                      if (user != null) {
                        ExtendedNavigator.of(context).push(Routes.profileScreen(
                            userId: user.pk, allowEdit: true));
                      }
                    },
                  ),
                  const SizedBox(width: AppInsets.l),
                ],
                bottom: TabBar(
                  labelColor: Colors.grey[800],
                  unselectedLabelColor: Colors.grey[400],
                  isScrollable: true,
                  labelStyle: labelStyle,
                  controller: _tabController,
                  indicatorColor: Theme.of(context).primaryColor,
                  indicatorWeight: 4.0,
                  tabs: _tabs,
                ),
              ),
            ),
          ];
        },
        body: DefaultStickyHeaderController(
          child: TabBarView(
            controller: _tabController,
            children: [
              ConversationCalendarTab(
                type: ConversationTabType.all,
                controller: _scrollController,
              ),
              ConversationCalendarTab(
                type: ConversationTabType.my,
                controller: _scrollController,
              ),
              InboxTab(),
              ArticlesTab(),
            ],
          ),
        ),
      ),
      floatingActionButton:
          _getFloatinActionButton(context, _activeTab.value, _tabController),
    );
  }

  Widget _getFloatinActionButton(
      BuildContext context, int index, TabController controller) {
    if (index == 0 || index == 1) {
      return FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(CreateConversationSheet()).then(
            (value) {
              if (value != null && value is Topic) {
                ExtendedNavigator.of(context)
                    .pushCreateConversationScreen(topic: value)
                    .then((value) {
                  if (value is Optin) {
                    controller.animateTo(1);
                  }
                });
              }
            },
          );
        },
        label: Text("Schedule New"),
        icon: Icon(Icons.add),
      );
    }
    return null;
  }
}
