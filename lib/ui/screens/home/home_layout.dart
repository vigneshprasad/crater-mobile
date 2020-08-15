import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worknetwork/blocs/post/bloc/post_bloc.dart';
import 'package:worknetwork/constants/work_net_icons_icons.dart';
import 'package:worknetwork/routes.dart';
import 'package:worknetwork/ui/base/base_app_bar/base_app_bar.dart';
import 'package:worknetwork/ui/components/app_drawer/app_drawer.dart';

class HomeLayout extends StatefulWidget {
  final List<BottomNavigationBarItem> navItems;
  final List<Widget> screens;
  final Function(int) onTabTapped;

  const HomeLayout(
      {Key key,
      @required this.navItems,
      @required this.screens,
      this.onTabTapped})
      : super(key: key);

  @override
  _HomeLayoutState createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        actions: <Widget>[
          IconButton(
            color: Colors.black87,
            icon: const Icon(WorkNetIcons.notification),
            onPressed: () {},
          )
        ],
      ),
      drawer: AppDrawer(),
      body: widget.screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        selectedFontSize: 12,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.black38,
        items: widget.navItems,
      ),
      floatingActionButton: getFloatingActionButton(context),
    );
  }

  void onTabTapped(int tabIndex) {
    setState(() {
      _currentIndex = tabIndex;
    });
    widget.onTabTapped != null ?? widget.onTabTapped(tabIndex);
  }

  Widget getFloatingActionButton(BuildContext context) {
    if (_currentIndex == 0) {
      return FloatingActionButton(
        onPressed: () {
          final _postbloc = BlocProvider.of<PostBloc>(context);
          Navigator.of(context)
              .pushNamed(Routes.createPost, arguments: _postbloc);
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(WorkNetIcons.newPost),
      );
    }
    if (_currentIndex == 2) {
      return FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(Routes.chatSearch);
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(WorkNetIcons.message),
      );
    }
    return null;
  }
}
