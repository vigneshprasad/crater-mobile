import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../constants/theme.dart';
import '../../../../constants/work_net_icons_icons.dart';
import '../../../../routes.gr.dart';
import '../../components/home_screen_app_bar/home_screen_app_bar.dart';

class TabWithTabbarLayout extends StatelessWidget {
  final String heading;
  final String? subheading;
  final Widget tabbar;
  final Widget body;

  const TabWithTabbarLayout({
    Key? key,
    required this.tabbar,
    required this.heading,
    required this.body,
    this.subheading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverPersistentHeader(
                pinned: true,
                delegate: PersistentTabbarLayout(
                  heading: heading,
                  subHeading: subheading,
                  tabbar: tabbar,
                  appBarActions: [
                    IconButton(
                      color: Colors.black87,
                      icon: const Icon(WorkNetIcons.notification),
                      onPressed: () {
                        AutoRouter.of(context)
                            .push(const NotificationsScreenRoute());
                      },
                    )
                  ],
                ),
              ),
            )
          ];
        },
        body: body,
      ),
    );
  }
}

class PersistentTabbarLayout extends SliverPersistentHeaderDelegate {
  final List<Widget> appBarActions;
  final String? heading;
  final String? subHeading;
  final Color? color;
  final Widget tabbar;

  PersistentTabbarLayout({
    required this.appBarActions,
    this.heading,
    required this.tabbar,
    this.subHeading,
    this.color,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final offset = shrinkOffset / (maxExtent - minExtent);
    final elevation =
        offset > 0.7 ? kElevationToShadow[1] : kElevationToShadow[0];
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          constraints.constrainHeight(shrinkOffset * maxExtent);
          return Stack(
            fit: StackFit.expand,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                decoration: BoxDecoration(
                  color: color ?? Colors.grey[100],
                  boxShadow: elevation,
                ),
                height: constraints.maxHeight,
              ),
              Positioned(
                top: AppTheme.appBarHeight.height,
                child: Opacity(
                  opacity: 1 - offset,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(
                      vertical: AppInsets.med,
                      horizontal: AppInsets.xl,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (heading != null)
                          Text(
                            heading!,
                            textAlign: TextAlign.start,
                            style:
                                Theme.of(context).textTheme.headline5?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 24,
                                    ),
                          ),
                        const SizedBox(height: AppPadding.tiny),
                        if (subHeading != null)
                          Text(
                            subHeading!,
                            style:
                                Theme.of(context).textTheme.subtitle1?.copyWith(
                                      color: Colors.grey[500],
                                    ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: HomeScreenAppBar(
                  title: Opacity(
                    opacity: offset,
                    child: Text(heading!, style: AppTheme.appBarTitle),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 56,
                  child: tabbar,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  double get maxExtent => 172;

  @override
  double get minExtent => 96;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
