import 'package:flutter/material.dart';

import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/ui/base/base_app_bar/base_app_bar.dart';

class NotifficationScreenHeader extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final Color color;
  final String heading;
  final String subHeading;

  NotifficationScreenHeader({
    this.color,
    this.heading,
    this.subHeading,
    @required this.expandedHeight,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final elevation = shrinkOffset / maxExtent > 0.4
        ? kElevationToShadow[2]
        : kElevationToShadow[0];
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            fit: StackFit.expand,
            overflow: Overflow.clip,
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
                                  .copyWith(fontWeight: FontWeight.w700),
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
              Align(
                alignment: Alignment.topRight,
                child: BaseAppBar(
                  title: Opacity(
                    opacity: shrinkOffset / maxExtent,
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
