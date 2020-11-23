import 'package:flutter/material.dart';

import '../../../ui/components/app_drawer/app_drawer.dart';

class HomeScreenLayout extends StatelessWidget {
  final List<BottomNavigationBarItem> navItems;
  final List<Widget> screens;
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
    return Scaffold(
      body: screen,
      drawer: AppDrawer(),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.white,
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
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
