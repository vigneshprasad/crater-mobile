import 'package:flutter/material.dart';

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
          type: BottomNavigationBarType.fixed,
          items: navItems,
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
}
