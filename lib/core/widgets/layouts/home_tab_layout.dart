import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:worknetwork/constants/work_net_icons_icons.dart';
import 'package:worknetwork/features/points/presentation/widgets/points_badge.dart';

import '../../../routes.gr.dart';
import '../components/persistent_tab_header.dart';

class HomeTabLayout extends StatelessWidget {
  final String heading;
  final String subheading;
  final Widget list;

  const HomeTabLayout({
    Key key,
    @required this.heading,
    @required this.subheading,
    @required this.list,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverPersistentHeader(
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
            )
          ];
        },
        body: list,
      ),
    );
  }
}
