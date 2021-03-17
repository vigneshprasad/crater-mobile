import 'package:auto_route/auto_route.dart';
import 'package:auto_route/auto_route_annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';

import '../../../constants/work_net_icons_icons.dart';
import '../../../features/article/presentation/bloc/article_bloc.dart';
import '../../../features/article/presentation/widgets/articles_tab.dart';
import '../../../features/chat_inbox/presentation/bloc/chat_inbox/chat_inbox_bloc.dart';
import '../../../features/chat_inbox/presentation/widgets/inbox_tab.dart';
import '../../../features/community/presentation/bloc/community/community_bloc.dart';
import '../../../features/meeting/presentation/widgets/meeting_tab.dart';
import '../../../features/rewards/presentation/widgets/rewards_tab.dart';
import '../../../features/roundtable/domain/entity/topic_entity/topic_entity.dart';
import '../../../features/roundtable/presentation/screens/create_table_sheet/create_roundtable_sheet.dart';
import '../../../features/roundtable/presentation/widgets/roundtable_tab/roundtable_tab.dart';
import '../../../routes.gr.dart';
import '../../../utils/app_localizations.dart';
import '../../analytics/analytics.dart';
import '../layouts/home_screen_layout.dart';

class HomeScreen extends StatefulWidget {
  final int tabIndex;

  const HomeScreen({
    @PathParam("tab") this.tabIndex,
  });

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CommunityBloc _communityBloc = KiwiContainer().resolve();
  final ArticleBloc _articleBloc = KiwiContainer().resolve();
  final ChatInboxBloc _chatInboxBloc = KiwiContainer().resolve<ChatInboxBloc>();
  int _currentTab = 0;

  final List<Widget> _screens = [
    RoundTableTab(),
    InboxTab(),
    // CommunityTab(),
    ArticlesTab(),
    RewardsTab(),
  ];

  @override
  void initState() {
    if (widget.tabIndex != null) {
      setState(() {
        _currentTab = widget.tabIndex;
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    _communityBloc.close();
    _articleBloc.close();
    _chatInboxBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: _communityBloc,
        ),
        BlocProvider.value(
          value: _articleBloc,
        ),
        BlocProvider.value(
          value: _chatInboxBloc,
        ),
      ],
      child: HomeScreenLayout(
        navItems: getNavItems(context),
        screens: _screens,
        getFabButton: getFloatingActionButton,
        onTabTapped: _onTabTapped,
        currentTabIndex: _currentTab,
        floatingActionButtonLocation: _getFabLocation(_currentTab),
      ),
    );
  }

  FloatingActionButtonLocation _getFabLocation(int index) {
    if (index == 0) {
      return FloatingActionButtonLocation.centerFloat;
    } else {
      return null;
    }
  }

  List<BottomNavigationBarItem> getNavItems(BuildContext context) {
    final translate = AppLocalizations.of(context).translate;
    // final String communityLabel = translate("home_tab:community");
    final String meetsLabel = translate("home_tab:meets");
    final String inboxLabel = translate("home_tab:inbox");
    final String articlesLabel = translate("home_tab:articles");
    final String rewardsLabel = translate("home_tab:rewards");
    final String roundTablesLabel = translate("home_tab:roundTable");

    return [
      BottomNavigationBarItem(
        icon: const Icon(WorkNetIcons.community),
        label: roundTablesLabel,
      ),
      // BottomNavigationBarItem(
      //   icon: const Icon(WorkNetIcons.people),
      //   label: meetsLabel,
      // ),
      BottomNavigationBarItem(
        icon: const Icon(WorkNetIcons.inbox),
        label: inboxLabel,
      ),
      // BottomNavigationBarItem(
      //   icon: const Icon(WorkNetIcons.community),
      //   title: Text(communityLabel),
      // ),
      BottomNavigationBarItem(
        icon: const Icon(WorkNetIcons.articles),
        label: articlesLabel,
      ),
      BottomNavigationBarItem(
        icon: const Icon(WorkNetIcons.staroutline),
        label: rewardsLabel,
      ),
    ];
  }

  Widget getFloatingActionButton(int index) {
    // New Post FAB
    // if (index == 2) {
    //   return FloatingActionButton(
    //     onPressed: () {
    //       ExtendedNavigator.of(context)
    //           .push(Routes.createPostScreen)
    //           .then((value) {
    //         if (value != null) {
    //           final post = value as Post;
    //           _communityBloc.add(NewPostCreated(post: post));
    //         }
    //       });
    //     },
    //     backgroundColor: Theme.of(context).primaryColor,
    //     child: const Icon(WorkNetIcons.newpost),
    //   );
    // }

    // RoundTables FAB
    if (index == 0) {
      final label =
          AppLocalizations.of(context).translate("conversations:start");
      return FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context)
              .push<Object>(CreateRoundTableSheet())
              .then((value) {
            if (value is Topic && value != null) {
              ExtendedNavigator.of(context).push(
                Routes.createTableScreen,
                arguments: CreateTableScreenArguments(topic: value),
              );
            }
          });
        },
        label: Text(label),
        icon: Icon(Icons.add),
      );
    }

    // Chat Search FAB
    if (index == 1) {
      return FloatingActionButton(
        onPressed: () {
          ExtendedNavigator.of(context).push(Routes.chatSearchScreen);
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(WorkNetIcons.message),
      );
    }
    return null;
  }

  void _onTabTapped(int index) {
    final tabNames = [
      "meeting_tab",
      "inbox_tab",
      "articles_tab",
      "rewards_tab",
    ];
    KiwiContainer()
        .resolve<Analytics>()
        .trackScreen(screenName: tabNames[index]);
    setState(() {
      _currentTab = index;
    });
  }
}
