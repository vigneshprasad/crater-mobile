import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';

import '../../../blocs/article/bloc/article_bloc.dart';
import '../../../blocs/meeting/bloc/meeting_bloc.dart';
import '../../../constants/work_net_icons_icons.dart';
import '../../../features/chat_inbox/presentation/bloc/chat_inbox/chat_inbox_bloc.dart';
import '../../../features/chat_inbox/presentation/widgets/inbox_tab.dart';
import '../../../features/community/presentation/bloc/community/community_bloc.dart';
import '../../../features/community/presentation/widgets/community_tab.dart';
import '../../../features/videos/presentation/bloc/video/video_bloc.dart';
import '../../../features/videos/presentation/widgets/videos_tab.dart';
import '../../../routes.gr.dart';
import '../../../ui/screens/home/tabs/articles_tab.dart';
import '../../../ui/screens/home/tabs/meets_tab.dart';
import '../../../utils/app_localizations.dart';
import '../layouts/home_screen_layout.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CommunityBloc _communityBloc = KiwiContainer().resolve();
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
          value: _videoBloc,
        ),
        BlocProvider.value(
          value: _meetingBloc,
        ),
        BlocProvider.value(
          value: _chatInboxBloc,
        ),
      ],
      child: HomeScreenLayout(
        navItems: getNavItems(context),
        screens: _screens,
        getFabButton: getFloatingActionButton,
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

  Widget getFloatingActionButton(int index) {
    if (index == 0) {
      return FloatingActionButton(
        onPressed: () {
          // final _postbloc = BlocProvider.of<PostBloc>(context);
          // ExtendedNavigator.of(context).push(Routes.createPost,
          //     arguments: CreatePostArguments(postBloc: _postbloc));
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(WorkNetIcons.newpost),
      );
    }
    if (index == 2) {
      return FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(Routes.chatSearchScreen);
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(WorkNetIcons.message),
      );
    }
    return null;
  }
}
