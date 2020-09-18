import 'package:flutter/material.dart';

import '../../../constants/work_net_icons_icons.dart';
import '../../../ui/components/app_drawer/app_drawer.dart';
import '../../../utils/app_localizations.dart';
import '../screens/models/home_screen_tab_model.dart';
import 'home_screen_body_layout.dart';

class HomeScreenLayout extends StatelessWidget {
  final List<BottomNavigationBarItem> navItems;
  final List<HomeScreenTab> screens;
  final Widget Function(int) getFabButton;
  final void Function(int) onTabTapped;
  final int currentTabIndex;

  const HomeScreenLayout({
    Key key,
    @required this.navItems,
    @required this.screens,
    @required this.getFabButton,
    @required this.onTabTapped,
    @required this.currentTabIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screen = screens[currentTabIndex];
    final String title =
        AppLocalizations.of(context).translate(screen.headingKey);
    final String subtitle =
        AppLocalizations.of(context).translate(screen.subheadingKey);
    return Scaffold(
      body: HomeScreenBodyLayout(
        heading: title,
        subheading: subtitle,
        body: screen,
        expandedHeight: screen.expandedHeight,
      ),
      drawer: AppDrawer(),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.white,
        ),
        child: BottomNavigationBar(
          items: _getNavItems(context),
          currentIndex: currentTabIndex,
          onTap: onTabTapped,
          unselectedItemColor: Colors.grey[400],
          selectedFontSize: 12,
          selectedItemColor: Theme.of(context).primaryColor,
        ),
      ),
      floatingActionButton: getFabButton(currentTabIndex),
    );
  }

  List<BottomNavigationBarItem> _getNavItems(BuildContext context) {
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
