import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../constants/theme.dart';
import '../sliver_obstruction_injector/sliver_obstruction_injector.dart';

const kCardBorderRadius = 8.00;
const kLeftPaddingForDate = 20.00;

class ConversationTabShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).canvasColor,
      highlightColor: Theme.of(context).scaffoldBackgroundColor,
      child: CustomScrollView(
        slivers: [
          SliverObstructionInjector(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          ),
          const SliverPadding(padding: EdgeInsets.only(top: AppInsets.xl)),
          for (int i = 0; i < 2; i++)
            SliverStickyHeader(
              overlapsContent: true,
              header: _DateShimmer(),
              sliver: SliverPadding(
                padding: const EdgeInsets.only(
                  left: kLeftPaddingForDate,
                  right: AppInsets.xl,
                  top: 60,
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => _CardShimmer(),
                    childCount: 4,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _DateShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppInsets.l),
      child: Align(
        child: Container(
          height: 30.00,
          width: 200.0,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class _CardShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppInsets.med),
      child: Container(
        height: 200,
        color: Colors.white,
      ),
    );
  }
}
