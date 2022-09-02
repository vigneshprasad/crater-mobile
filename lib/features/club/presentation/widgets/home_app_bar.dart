import 'package:flutter/material.dart';
import 'package:worknetwork/core/color/color.dart';

class HomeAppBar extends StatelessWidget {
  final String title;
  final double? leftPadding;
  const HomeAppBar({
    required this.title,
    this.leftPadding,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 64,
      flexibleSpace: AccentTitle(
        title: title,
        leftPadding: leftPadding,
      ),
    );
  }
}

class AccentTitle extends StatelessWidget {
  const AccentTitle({
    Key? key,
    required this.title,
    this.leftPadding,
  }) : super(key: key);

  final String title;
  final double? leftPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: leftPadding ?? 16.0, top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headline5,
          ),
          const SizedBox(height: 8),
          Container(
            height: 2,
            width: 64,
            color: HexColor.fromHex('#D5BBFF'),
          ),
        ],
      ),
    );
  }
}
