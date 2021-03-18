import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/features/meeting/domain/entity/meeting_entity.dart';
import 'package:worknetwork/features/roundtable/presentation/widgets/meeting_card/meeting_card.dart';

import '../../../../../routes.gr.dart';
import '../../../domain/entity/roundtable_entity/roundtable_entity.dart';
import '../roundtable_card/roundtable_card.dart';
import '../roundtable_tab/roundtable_tab.dart';
import 'roundtables_page_state.dart';

class RoundTablesPage extends HookWidget {
  final RoundTablePageType type;

  const RoundTablesPage({
    @required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final _pageController = usePageController(
      viewportFraction: 0.85,
    );
    final state = useProvider(roundtablePageStateProvider(type).state);

    return state.when(
      loading: () => _Loader(),
      data: (data) {
        final List<Widget> children = [];
        for (final table in data.tables) {
          children.add(
            RoundTableCard(
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
            ),
          );
        }

        if (type == RoundTablePageType.user) {
          for (final optin in data.optins) {
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

          for (final meeting in data.meetings) {
            children.add(MeetingCard(
              meeting: meeting,
              onPressed: (value) {
                final _meeting = value;
                ExtendedNavigator.of(context)
                    .pushMeetingDetailScreen(meetingId: _meeting.pk);
              },
            ));
          }
        }

        return Expanded(
          child: PageView(
            controller: _pageController,
            children: children,
          ),
        );
      },
      error: (error, st) => _Loader(),
    );
  }
}

class _Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Expanded(
        child: Center(
      child: SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(),
      ),
    ));
  }
}
