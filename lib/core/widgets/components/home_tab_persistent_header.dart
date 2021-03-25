import 'package:flutter/material.dart';

import '../../../constants/theme.dart';
import 'home_screen_app_bar/home_screen_app_bar.dart';

class HomeTabPersistentHeader extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final Color color;
  final String heading;
  final String subHeading;
  final List<Widget> appBarActions;

  HomeTabPersistentHeader({
    @required this.expandedHeight,
    this.color,
    this.heading,
    this.subHeading,
    this.appBarActions,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final elevation = shrinkOffset / maxExtent > 0.4
        ? kElevationToShadow[1]
        : kElevationToShadow[0];
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          constraints.constrainHeight(shrinkOffset * expandedHeight);
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
              if (shrinkOffset / maxExtent < 0.3)
                Opacity(
                  opacity: 1 - shrinkOffset / maxExtent,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppInsets.xl,
                        horizontal: AppInsets.xl,
                      ),
                      child: SizedBox.expand(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (heading != null)
                              Text(
                                heading,
                                textAlign: TextAlign.start,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    .copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 24,
                                    ),
                              ),
                            const SizedBox(height: AppPadding.tiny),
                            if (subHeading != null)
                              Text(
                                subHeading,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(
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
                ),
              Align(
                alignment: Alignment.topRight,
                child: HomeScreenAppBar(
                  title: Opacity(
                    opacity: shrinkOffset / maxExtent > 0.4
                        ? 1
                        : shrinkOffset / maxExtent,
                    child: Text(heading, style: AppTheme.appBarTitle),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => AppTheme.appBarHeight.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
