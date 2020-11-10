import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../constants/work_net_icons_icons.dart';
import '../../../routes.gr.dart';
import '../components/home_tab_persistent_header.dart';

typedef RefreshCallback = Future<void> Function();

class HomeScreenBodyLayout extends StatelessWidget {
  final double expandedHeight;
  final String heading;
  final String subheading;
  final Widget body;

  const HomeScreenBodyLayout({
    Key key,
    this.expandedHeight = 116,
    @required this.heading,
    @required this.body,
    this.subheading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: NestedScrollView(
        dragStartBehavior: DragStartBehavior.down,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverPersistentHeader(
                pinned: true,
                delegate: HomeTabPersistentHeader(
                  expandedHeight: expandedHeight,
                  heading: heading,
                  subHeading: subheading,
                  appBarActions: [
                    IconButton(
                      color: Colors.black87,
                      icon: const Icon(WorkNetIcons.notification),
                      onPressed: () {
                        ExtendedNavigator.of(context)
                            .push(Routes.notificationsScreen);
                      },
                    )
                  ],
                ),
              ),
            ),
          ];
        },
        body: body,
      ),
    );
  }
}
