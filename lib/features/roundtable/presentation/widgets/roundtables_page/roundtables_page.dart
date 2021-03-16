import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:worknetwork/features/meeting/domain/entity/meeting_entity.dart';

import '../../../../../routes.gr.dart';
import '../../../domain/entity/optin_entity/optin_entity.dart';
import '../../../domain/entity/roundtable_entity/roundtable_entity.dart';
import '../roundtable_card/roundtable_card.dart';
import '../roundtable_tab/roundtable_tab.dart';

class RoundTablesPage extends HookWidget {
  final RoundTablePageType type;
  final List<RoundTable> tables;
  final List<Optin> optins;
  final List<Meeting> meetings;

  const RoundTablesPage({
    @required this.type,
    @required this.tables,
    this.optins,
    this.meetings,
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
        description: table.topicDetail.description,
        rootTopicLabel: table.topicDetail.root?.name,
        startTime: table.start,
        endTime: table.end,
        topicLabel: table.topicDetail.name ?? "",
        interests: table.interestsDetailList,
        speakers: table.speakersDetailList,
        onPressed: (value) {
          if (value is RoundTable) {
            ExtendedNavigator.of(context)
                .push(Routes.roundTableScreen(id: table.id));
          }
        },
      ));
    }

    if (type == RoundTablePageType.user) {
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

      for (final meeting in meetings) {
        children.add(RoundTableCard(
          data: meeting,
          topicLabel: meeting.participants[0].name,
          startTime: meeting.start,
          endTime: meeting.end,
          onPressed: (value) {
            final _meeting = value as Meeting;
            ExtendedNavigator.of(context)
                .pushMeetingDetailScreen(meetingId: _meeting.pk);
          },
        ));
      }
    }

    return PageView(
      controller: _pageController,
      children: children,
    );
  }
}
