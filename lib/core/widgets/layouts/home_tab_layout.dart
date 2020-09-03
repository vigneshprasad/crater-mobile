import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/constants/work_net_icons_icons.dart';
import 'package:worknetwork/features/points/presentation/widgets/points_badge.dart';

import '../../../routes.gr.dart';
import '../components/persistent_tab_header.dart';

typedef RefreshCallback = Future<void> Function();

class HomeTabLayout extends StatelessWidget {
  final String heading;
  final String subheading;
  final RefreshCallback onRefresh;
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final ScrollController listController;
  final EdgeInsetsGeometry listPadding;

  const HomeTabLayout({
    Key key,
    this.listController,
    this.listPadding,
    @required this.heading,
    @required this.subheading,
    @required this.onRefresh,
    @required this.itemBuilder,
    @required this.itemCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: NestedScrollView(
        controller: listController,
        dragStartBehavior: DragStartBehavior.down,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverPersistentHeader(
                pinned: true,
                delegate: PersistentTabHeader(
                  expandedHeight: 116,
                  heading: heading,
                  subHeading: subheading,
                  appBarActions: [
                    PointsBadge(),
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
                      context,
                    ),
                  ),
                  SliverPadding(
                    padding: listPadding ?? const EdgeInsets.all(0),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        itemBuilder,
                        childCount: itemCount,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
