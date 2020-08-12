import 'package:flutter/material.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/ui/base/tab_header/tab_header.dart';
import 'package:worknetwork/utils/app_localizations.dart';

class HomeTabLayout extends StatelessWidget {
  final String titleKey;
  final String subtitleKey;
  final Widget body;
  final Widget action;

  const HomeTabLayout({
    Key key,
    this.titleKey,
    this.subtitleKey,
    this.action,
    this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String title = AppLocalizations.of(context).translate(titleKey) ?? "";
    final String subtitle =
        AppLocalizations.of(context).translate(subtitleKey) ?? "";
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: AppInsets.xl,
            right: AppInsets.med,
          ),
          child: TabHeader(
            heading: title,
            subHeading: subtitle,
            action: action,
          ),
        ),
        Expanded(child: body),
      ],
    );
  }
}
