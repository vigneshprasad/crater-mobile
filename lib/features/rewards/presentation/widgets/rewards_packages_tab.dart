import 'package:flutter/material.dart';

import '../../../../constants/theme.dart';
import '../../domain/entity/package_entity.dart';
import 'package_card.dart';

class RewardsPackagesTab extends StatefulWidget {
  final List<Package> packages;
  final RefreshCallback onRefresh;

  const RewardsPackagesTab({
    Key key,
    @required this.packages,
    @required this.onRefresh,
  }) : super(key: key);

  @override
  _RewardsPackagesTabState createState() => _RewardsPackagesTabState();
}

class _RewardsPackagesTabState extends State<RewardsPackagesTab> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: widget.onRefresh,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverOverlapInjector(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          ),
          _buildList(context),
        ],
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    if (widget.packages.isNotEmpty) {
      return SliverPadding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppInsets.med,
          vertical: AppInsets.med,
        ),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
            _buildPackageItem,
            childCount: widget.packages.length,
          ),
        ),
      );
    } else {
      return SliverToBoxAdapter(
        child: Container(),
      );
    }
  }

  Widget _buildPackageItem(BuildContext context, int index) {
    final package = widget.packages[index];
    return PackageCard(package: package);
  }
}
