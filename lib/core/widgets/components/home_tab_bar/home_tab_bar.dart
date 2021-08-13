import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../constants/theme.dart';

class HomeTabItem extends Equatable {
  final String label;
  final String id;

  const HomeTabItem({
    required this.label,
    required this.id,
  });

  @override
  List<Object> get props => [
        label,
        id,
      ];
}

class HomeTabBar extends StatelessWidget {
  final TabController controller;
  final Color backgroundColor;
  final List<HomeTabItem> tabs;

  const HomeTabBar({
    Key? key,
    this.backgroundColor = Colors.transparent,
    required this.tabs,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => _TabItem(
          item: tabs[index],
          active: index == controller.index,
        ),
        itemCount: tabs.length,
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final bool active;
  final HomeTabItem item;

  const _TabItem({
    Key? key,
    required this.item,
    required this.active,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(context).textTheme.bodyText1?.copyWith(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: active ? Colors.grey[800] : Colors.grey[400],
        );
    return Material(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppInsets.med,
        ),
        decoration: BoxDecoration(
          border: active
              ? Border(
                  bottom: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 4.00,
                  ),
                )
              : null,
        ),
        child: Center(
          child: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(24.00)),
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppInsets.med,
                horizontal: AppInsets.l,
              ),
              child: Text(
                item.label,
                style: labelStyle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
