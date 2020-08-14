import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worknetwork/blocs/article/bloc/article_bloc.dart';
import 'package:worknetwork/blocs/masterclass/bloc/masterclass_bloc.dart';
import 'package:worknetwork/blocs/meeting/bloc/meeting_bloc.dart';
import 'package:worknetwork/blocs/notification/bloc/notification_bloc.dart';
import 'package:worknetwork/blocs/post/bloc/post_bloc.dart';
import 'package:worknetwork/constants/work_net_icons_icons.dart';
import 'package:worknetwork/ui/base/base_badge/base_badge.dart';
import 'package:worknetwork/ui/screens/home/home_layout.dart';
import 'package:worknetwork/ui/screens/home/tabs/articles_tab.dart';
import 'package:worknetwork/ui/screens/home/tabs/community_tab.dart';
import 'package:worknetwork/ui/screens/home/tabs/meets_tab.dart';
import 'package:worknetwork/ui/screens/home/tabs/inbox_tab.dart';
import 'package:worknetwork/ui/screens/home/tabs/videos_tab.dart';
import 'package:worknetwork/utils/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PostBloc _postBloc = PostBloc();
  final ArticleBloc _articleBloc = ArticleBloc();
  final MasterclassBloc _masterclassBloc = MasterclassBloc();
  final MeetingBloc _meetingBloc = MeetingBloc()..add(MeetingGetStarted());
  int _unreadCount = 0;

  final List<Widget> _screens = [
    CommunityTab(),
    MeetsTab(),
    InboxTab(),
    ArticlesTab(),
    VideoTab()
  ];

  @override
  void dispose() {
    _postBloc.close();
    _articleBloc.close();
    _masterclassBloc.close();
    _meetingBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: _postBloc,
        ),
        BlocProvider.value(
          value: _articleBloc,
        ),
        BlocProvider.value(
          value: _masterclassBloc,
        ),
        BlocProvider.value(
          value: _meetingBloc,
        ),
      ],
      child: HomeLayout(
        navItems: getNavItems(context),
        screens: _screens,
      ),
    );
  }

  List<BottomNavigationBarItem> getNavItems(BuildContext context) {
    final translate = AppLocalizations.of(context).translate;
    final String communityLabel = translate("home_tab:community");
    final String meetsLabel = translate("home_tab:meets");
    final String inboxLabel = translate("home_tab:inbox");
    final String articlesLabel = translate("home_tab:articles");
    final String videosLabel = translate("home_tab:videos");

    return [
      BottomNavigationBarItem(
        icon: const Icon(WorkNetIcons.community),
        title: Text(communityLabel),
      ),
      BottomNavigationBarItem(
        icon: const Icon(WorkNetIcons.people),
        title: Text(meetsLabel),
      ),
      BottomNavigationBarItem(
        icon: BlocListener<NotificationBloc, NotificationState>(
          listener: (context, state) {
            if (state is MessageNotificationLoaded) {
              setState(() {
                final int count = state.messageNotifcations.fold(
                    0,
                    (previousValue, element) =>
                        previousValue += element.unreadCount);
                _unreadCount = count;
              });
            }
          },
          child: BaseBadge(
            count: _unreadCount,
            child: const Icon(WorkNetIcons.inbox),
          ),
        ),
        title: Text(inboxLabel),
      ),
      BottomNavigationBarItem(
        icon: const Icon(WorkNetIcons.articles),
        title: Text(articlesLabel),
      ),
      BottomNavigationBarItem(
        icon: const Icon(WorkNetIcons.videos),
        title: Text(videosLabel),
      ),
    ];
  }
}
