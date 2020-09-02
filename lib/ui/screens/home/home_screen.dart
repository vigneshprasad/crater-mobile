import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';
import 'package:worknetwork/features/notification/presentation/bloc/notification_bloc.dart';

import '../../../blocs/article/bloc/article_bloc.dart';
import '../../../blocs/meeting/bloc/meeting_bloc.dart';
import '../../../blocs/post/bloc/post_bloc.dart';
import '../../../constants/work_net_icons_icons.dart';
import '../../../features/chat_inbox/presentation/bloc/chat_inbox/chat_inbox_bloc.dart';
import '../../../features/chat_inbox/presentation/widgets/inbox_tab.dart';
import '../../../features/videos/presentation/bloc/video/video_bloc.dart';
import '../../../features/videos/presentation/widgets/videos_tab.dart';
import '../../../utils/app_localizations.dart';
import 'home_layout.dart';
import 'tabs/articles_tab.dart';
import 'tabs/community_tab.dart';
import 'tabs/meets_tab.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PostBloc _postBloc = PostBloc();
  final ArticleBloc _articleBloc = ArticleBloc();
  final VideoBloc _videoBloc = KiwiContainer().resolve();
  final MeetingBloc _meetingBloc = MeetingBloc()..add(MeetingGetStarted());
  final ChatInboxBloc _chatInboxBloc = KiwiContainer().resolve<ChatInboxBloc>();

  final List<Widget> _screens = [
    CommunityTab(),
    MeetsTab(),
    InboxTab(),
    ArticlesTab(),
    VideoTab()
  ];

  @override
  void initState() {
    BlocProvider.of<NotificationBloc>(context)
        .add(const GetNotificationsRequestStarted(page: 1, pageSize: 10));
    super.initState();
  }

  @override
  void dispose() {
    _postBloc.close();
    _articleBloc.close();
    _videoBloc.close();
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
          value: _videoBloc,
        ),
        BlocProvider.value(
          value: _meetingBloc,
        ),
        BlocProvider.value(
          value: _chatInboxBloc,
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
        icon: const Icon(WorkNetIcons.inbox),
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
