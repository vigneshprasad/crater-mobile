import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../../routes.gr.dart';
import '../../../domain/entity/optin_entity/optin_entity.dart';
import '../../../domain/entity/roundtable_entity/roundtable_entity.dart';
import '../roundtable_card/roundtable_card.dart';
import '../roundtable_tab/roundtable_tab.dart';

class RoundTablesPage extends HookWidget {
  final RoundTablePageType type;
  final List<RoundTable> tables;
  final List<Optin> optins;

  const RoundTablesPage({
    @required this.type,
    @required this.tables,
    this.optins,
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [];
    final _pageController = usePageController(
      viewportFraction: 0.85,
    );

    for (final table in tables) {
      children.add(RoundTableCard(
        data: table,
        description: table.topic.description,
        rootTopicLabel: table.topic.root?.name,
        startTime: table.start,
        endTime: table.end,
        topicLabel: table.topic.name ?? "",
        interests: table.interests,
        speakers: table.speakers,
        onPressed: (value) {
          if (value is RoundTable) {
            ExtendedNavigator.of(context)
                .push(Routes.roundTableScreen(id: table.id));
          }
        },
      ));
    }

    if (type == RoundTablePageType.user && optins.isNotEmpty) {
      for (final optin in optins) {
        final startTime = optin.timeSlotList[0].start;
        final endTime = optin.timeSlotList[0].start;
        children.add(RoundTableCard(
          data: optin,
          rootTopicLabel: optin.topicDetail.root?.name,
          topicLabel: optin.topicDetail.name,
          startTime: startTime,
          endTime: endTime,
          interests: optin.interestList,
          isOptin: true,
        ));
      }
    }

    return PageView(
      controller: _pageController,
      children: children,
    );
  }
}
