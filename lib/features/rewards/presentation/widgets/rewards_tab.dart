import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/theme.dart';
import '../../../../core/widgets/base/base_tab_bar/base_tab_bar.dart';
import '../../../../core/widgets/layouts/tab_layouts/tab_with_tabbar_layout.dart';
import '../../../../utils/app_localizations.dart';
import '../../../meeting/presentation/widgets/register_meeting_button.dart';
import '../../../points/presentation/widgets/points_tab.dart';
import '../../domain/entity/package_entity.dart';
import '../bloc/rewards_bloc.dart';
import 'rewards_packages_tab.dart';

class RewardsTab extends StatefulWidget {
  @override
  _RewardsTabState createState() => _RewardsTabState();
}

class _RewardsTabState extends State<RewardsTab>
    with
        AutomaticKeepAliveClientMixin<RewardsTab>,
        SingleTickerProviderStateMixin {
  late RewardsBloc _bloc;
  late TabController _tabController;
  late List<Package> _packages;
  int _currentIndex = 0;

  final List<Widget> tabs = [
    const BaseTab(text: "Deals"),
    const BaseTab(text: "Points")
  ];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _packages = [];
    _bloc = BlocProvider.of<RewardsBloc>(context);
    _tabController = TabController(length: tabs.length, vsync: this);
    initData();
    _tabController.addListener(() {
      setState(() {
        _currentIndex = _tabController.index;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void initData() {
    _bloc.add(const RewardsGetPackageListStarted());
  }

  @override
  Widget build(BuildContext context) {
    final heading = AppLocalizations.of(context)?.translate("rewards:title");
    final subheading =
        AppLocalizations.of(context)?.translate("rewards:subtitle");
    super.build(context);
    return BlocListener<RewardsBloc, RewardsState>(
      listener: _blockListener,
      child: TabWithTabbarLayout(
        heading: heading!,
        subheading: subheading,
        tabbar: BaseTabBar(
          controller: _tabController,
          tabs: tabs,
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            TabBarView(
              controller: _tabController,
              children: [
                RewardsPackagesTab(
                  packages: _packages,
                  onRefresh: () async {
                    return;
                  },
                ),
                const PointsTab(),
              ],
            ),
            if (_currentIndex == 1)
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: const EdgeInsets.only(bottom: AppInsets.xxl),
                  child: RegisterMeetingButton(
                    label: "Redeem Now",
                    onPressed: () {
                      _tabController.animateTo(0);
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _blockListener(BuildContext context, RewardsState state) {
    if (state is RewardsPackageListLoaded) {
      setState(() {
        _packages = state.packages!;
      });
    }
  }
}
