import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../constants/theme.dart';

typedef RefreshCallback = Future<void> Function();

class HomeTabLayout extends StatelessWidget {
  final RefreshCallback onRefresh;
  final ScrollController listController;
  final List<Widget> slivers;

  const HomeTabLayout({
    Key key,
    this.listController,
    @required this.onRefresh,
    @required this.slivers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return RefreshIndicator(
          onRefresh: onRefresh,
          displacement: AppTheme.appBarHeight.height + 50,
          child: CustomScrollView(
            controller: listController,
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverOverlapInjector(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              ),
              ...slivers,
            ],
          ),
        );
      },
    );
  }
}
