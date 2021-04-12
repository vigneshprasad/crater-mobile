import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/features/conversations/presentation/widgets/conversation_card/conversation_card.dart';
import 'package:worknetwork/features/conversations/presentation/widgets/sliver_obstruction_injector/sliver_obstruction_injector.dart';

import '../../../../../core/widgets/screens/home_screen/home_screen.dart';
import '../../../domain/entity/conversation_entity/conversation_entity.dart';
import 'conversation_calendar_tab_state.dart';

enum ConversationTabType {
  all,
  my,
}

class ConversationCalendarTab extends HookWidget {
  final ConversationTabType type;
  final ScrollController controller;

  const ConversationCalendarTab({
    @required this.type,
    @required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final _scrollController = useProvider(homeScreenScrollController);
    final state = useProvider(conversationCalendarTabStateProvider(type).state);

    return state.when(
      loading: () => _Loader(),
      data: (results) => _CalendarView(dates: results),
      error: (err, st) => _Loader(),
    );
  }
}

class _Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.green);
  }
}

class _CalendarView extends StatelessWidget {
  final List<ConversationByDate> dates;

  const _CalendarView({
    Key key,
    @required this.dates,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverObstructionInjector(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        ),
        for (final date in dates) ...[
          SliverStickyHeader.builder(
            overlapsContent: true,
            builder: (context, state) {
              return _DateLabel(date: date.date);
            },
            sliver: SliverPadding(
              padding: const EdgeInsets.only(
                left: 72.00,
                bottom: AppInsets.xl,
              ),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return ConversationCard(
                        conversation: date.conversations[index]);
                  },
                  childCount: date.conversations.length,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Divider(color: Colors.grey[300]),
          ),
        ],
        const SliverPadding(padding: EdgeInsets.only(bottom: 72.00)),
      ],
    );
  }
}

class _DateLabel extends StatelessWidget {
  final DateTime date;

  const _DateLabel({
    Key key,
    @required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final weekDayFormat = DateFormat("EEE");
    final dateFormat = DateFormat("d");
    final weekdayLabelStyle = Theme.of(context).textTheme.bodyText1.copyWith(
          fontSize: 14.00,
        );
    final dateLabelStyle = Theme.of(context).textTheme.bodyText1.copyWith(
          fontSize: 18.00,
          fontWeight: FontWeight.w700,
        );
    return Padding(
      padding: const EdgeInsets.all(AppInsets.xl),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          children: [
            Text(weekDayFormat.format(date), style: weekdayLabelStyle),
            const SizedBox(height: AppInsets.sm),
            Text(dateFormat.format(date), style: dateLabelStyle),
          ],
        ),
      ),
    );
  }
}
