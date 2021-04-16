import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:shimmer/shimmer.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/features/conversations/presentation/widgets/sliver_obstruction_injector/sliver_obstruction_injector.dart';

const kCardBorderRadius = 8.00;
const kLeftPaddingForDate = 72.00;

class ConversationTabShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[200],
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
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => _CardShimmer(),
                    childCount: 2,
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
        alignment: Alignment.centerLeft,
        child: Container(
          height: 48.00,
          width: 48.00,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
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
        height: 112,
        color: Colors.white,
      ),
    );
  }
}
