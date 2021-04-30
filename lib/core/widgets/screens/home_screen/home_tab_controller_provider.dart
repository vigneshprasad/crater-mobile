import 'package:flutter/material.dart';

class HomeTabControllerProvider extends InheritedWidget {
  final TabController controller;

  const HomeTabControllerProvider({
    Widget child,
    @required this.controller,
  }) : super(child: child);

  @override
  bool updateShouldNotify(HomeTabControllerProvider oldWidget) {
    return controller != oldWidget.controller;
  }

  static HomeTabControllerProvider of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType(aspect: HomeTabControllerProvider);
}
