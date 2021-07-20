import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../constants/theme.dart';
import '../../../constants/work_net_icons_icons.dart';
import '../../../routes.gr.dart';
import '../components/home_tab_persistent_header.dart';

typedef RefreshCallback = Future<void> Function();

class HomeTabLayout extends StatelessWidget {
  final RefreshCallback onRefresh;
  final ScrollController listController;
  final List<Widget> slivers;
  final String heading;
  final String subHeading;
  final double expandedHeight;

  const HomeTabLayout({
    Key key,
    this.listController,
    @required this.onRefresh,
    @required this.slivers,
    @required this.heading,
    this.subHeading,
    this.expandedHeight = 124,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: NestedScrollView(
        controller: listController,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverPersistentHeader(
                pinned: true,
                delegate: HomeTabPersistentHeader(
                  heading: heading,
                  subHeading: subHeading,
                  expandedHeight: expandedHeight,
                  appBarActions: [
                    IconButton(
                      color: Colors.black87,
                      icon: const Icon(WorkNetIcons.notification),
                      onPressed: () {
                        AutoRouter.of(context).push(Routes.notificationsScreen);
                      },
                    )
                  ],
                ),
              ),
            )
          ];
        },
        body: Builder(
          builder: (context) {
            return RefreshIndicator(
              onRefresh: onRefresh,
              displacement: AppTheme.appBarHeight.height + 50,
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverOverlapInjector(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                  ),
                  ...slivers,
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
