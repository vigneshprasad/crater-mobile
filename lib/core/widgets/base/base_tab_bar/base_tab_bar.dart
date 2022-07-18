import 'package:flutter/material.dart';

import 'package:worknetwork/constants/theme.dart';

class BaseTabBar extends StatefulWidget implements PreferredSizeWidget {
  final TabController controller;
  final List<Widget> tabs;

  const BaseTabBar({
    Key? key,
    required this.controller,
    required this.tabs,
  })  : assert(controller.length == tabs.length),
        super(key: key);

  @override
  _BaseTabBarState createState() => _BaseTabBarState();

  @override
  Size get preferredSize => const Size.fromHeight(56);
}

class _BaseTabBarState extends State<BaseTabBar> {
  late int _currentIndex;
  late List<GlobalKey> _tabKeys;
  late double indicatorWidth;
  late double indicatorPosition;

  @override
  void initState() {
    _currentIndex = widget.controller.index;
    _tabKeys = widget.tabs.map((Widget tab) => GlobalKey()).toList();
    indicatorWidth = 0;
    indicatorPosition = 0;
    WidgetsBinding.instance
        .addPostFrameCallback((_) => setIndicatorWidth(context));
    widget.controller.addListener(_onIndexChange);
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onIndexChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.preferredSize.width,
      height: widget.preferredSize.height,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppInsets.sm,
          horizontal: AppInsets.xl,
        ),
        margin: const EdgeInsets.only(bottom: AppInsets.med),
        child: Stack(
          fit: StackFit.expand,
          children: [
            AnimatedPositioned(
              bottom: 0,
              left: indicatorPosition,
              height: 4,
              duration: const Duration(milliseconds: 200),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: indicatorWidth,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: _buildTabs(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void setIndicatorWidth(BuildContext context) {
    final GlobalKey _tabKey = _tabKeys[_currentIndex];
    final renderBox = _tabKey.currentContext?.findRenderObject() as RenderBox?;

    final width = renderBox?.size.width;

    if (width != null && width.isFinite) {
      setState(() {
        indicatorWidth = width;
      });
    }
  }

  List<Widget> _buildTabs() {
    final List<Widget> tabs = [];

    for (int i = 0; i < widget.tabs.length; i++) {
      tabs.add(
        Container(
          margin: const EdgeInsets.only(right: AppInsets.l),
          child: KeyedSubtree(
            key: _tabKeys[i],
            child: Opacity(
              opacity: i == _currentIndex ? 1 : 0.4,
              child: GestureDetector(
                onTap: () {
                  if (_currentIndex != i) {
                    widget.controller.animateTo(i);
                  }
                },
                child: widget.tabs[i],
              ),
            ),
          ),
        ),
      );
    }
    return tabs;
  }

  void _onIndexChange() {
    setState(() {
      _currentIndex = widget.controller.index;
    });
    setIndicatorWidth(context);
    _updateIndicatorPosition();
  }

  void _updateIndicatorPosition() {
    final GlobalKey _tabKey = _tabKeys[_currentIndex];
    final renderBox = _tabKey.currentContext?.findRenderObject() as RenderBox?;

    final offset = renderBox?.localToGlobal(Offset.zero);
    if (offset != null && offset.dx > 0) {
      setState(() {
        indicatorPosition = offset.dx - AppInsets.xl;
      });
    }
  }
}

class BaseTab extends StatelessWidget {
  final String text;

  const BaseTab({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(context).textTheme.bodyText1?.copyWith(
          fontSize: 15,
        );
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppInsets.sm,
        horizontal: AppInsets.med,
      ),
      child: Center(
        child: Text(
          text,
          style: labelStyle,
        ),
      ),
    );
  }
}
