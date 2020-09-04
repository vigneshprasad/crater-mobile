import 'package:flutter/material.dart';

import '../../../constants/work_net_icons_icons.dart';
import '../../../ui/components/app_drawer/app_drawer.dart';
import '../../../utils/app_localizations.dart';

class HomeScreenLayout extends StatefulWidget {
  final List<BottomNavigationBarItem> navItems;
  final List<Widget> screens;
  final Widget Function(int) getFabButton;

  const HomeScreenLayout({
    Key key,
    @required this.navItems,
    @required this.screens,
    @required this.getFabButton,
  }) : super(key: key);

  @override
  _HomeScreenLayoutState createState() => _HomeScreenLayoutState();
}

class _HomeScreenLayoutState extends State<HomeScreenLayout> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.screens[_currentIndex],
      drawer: AppDrawer(),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.white,
        ),
        child: BottomNavigationBar(
          items: _getNavItems(context),
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
          unselectedItemColor: Colors.grey[400],
          selectedFontSize: 12,
          selectedItemColor: Theme.of(context).primaryColor,
        ),
      ),
      floatingActionButton: widget.getFabButton(_currentIndex),
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

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
