import 'package:flutter/material.dart';
import 'package:worknetwork/features/profile/presentation/widget/help_button.dart';
import 'package:worknetwork/features/profile/presentation/widget/share_button.dart';

class HomeAppBar extends StatelessWidget {
  final String title;
  const HomeAppBar({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 80,
      actions: [
        HelpButton(),
        ShareButton(),
      ],
      flexibleSpace: AccentTitle(title: title),
    );
  }
}

class AccentTitle extends StatelessWidget {
  const AccentTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 16),
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
            width: 16,
            color: Theme.of(context).accentColor,
          ),
        ],
      ),
    );
  }
}
