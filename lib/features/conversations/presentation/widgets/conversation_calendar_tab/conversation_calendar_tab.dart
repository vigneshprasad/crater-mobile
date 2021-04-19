import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:worknetwork/core/features/popup_manager/popup_manager.dart';
import 'package:worknetwork/features/conversations/presentation/widgets/conversation_tab_shimmer/conversation_tab_shimmer.dart';

import '../../../../../constants/app_constants.dart';
import '../../../../../constants/theme.dart';
import '../../../../../core/extensions/date_time_extensions.dart';
import '../../../../../utils/app_localizations.dart';
import '../conversation_card/conversation_card.dart';
import '../optin_card/optin_card.dart';
import '../sliver_obstruction_injector/sliver_obstruction_injector.dart';
import 'conversation_calendar_tab_state.dart';

const kLeftPaddingForDate = 72.00;

class ConversationCalendarTab extends HookWidget {
  final ConversationTabType type;
  final ScrollController controller;

  const ConversationCalendarTab({
    @required this.type,
    @required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final intialState = useProvider(initialStateProvider(type));

    return intialState.when(
      loading: () => ConversationTabShimmer(),
      data: (results) => _LoadedConversationTab(
        type: type,
      ),
      error: (err, st) => _Loader(),
    );
  }
}

class _Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.red);
  }
}

class _LoadedConversationTab extends HookWidget {
  final ConversationTabType type;

  const _LoadedConversationTab({
    Key key,
    @required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = useProvider(conversationCalendarStateProvider(type));
    final weeks = useProvider(conversationCalendarStateProvider(type).state);

    final List<Widget> children = [];

    final popupManager = useProvider(popupManagerProvider);
    popupManager.showPopup(PopupType.signupComplete, context);

    children.add(SliverObstructionInjector(
      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
    ));

    for (final week in weeks) {
      if (!week.future) {
        /// Add Conversations
        for (final date in week.conversations) {
          children.addAll([
            SliverStickyHeader.builder(
              overlapsContent: true,
              builder: (context, state) {
                return _DateLabel(date: date.date);
              },
              sliver: SliverPadding(
                padding: const EdgeInsets.only(
                  left: kLeftPaddingForDate,
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
          ]);
        }
      } else {
        if (week.optins.isEmpty) {
          children.add(_EmptyOptinsState());
        } else {
          for (final date in week.optins) {
            children.addAll([
              SliverStickyHeader.builder(
                overlapsContent: true,
                builder: (context, state) {
                  return _DateLabel(date: date.date);
                },
                sliver: SliverPadding(
                  padding: const EdgeInsets.only(
                    left: kLeftPaddingForDate,
                    bottom: AppInsets.xl,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final optin = date.optins[index];
                        return OptinCard(optin: optin);
                      },
                      childCount: date.optins.length,
                    ),
                  ),
                ),
              ),
            ]);
          }
        }
      }
    }

    return RefreshIndicator(
      displacement: 96.00,
      onRefresh: () {
        return controller.getPreviousWeekData();
      },
      child: CustomScrollView(
        slivers: [
          ...children,
          const SliverPadding(padding: EdgeInsets.only(bottom: 140.00)),
        ],
      ),
    );
  }
}

class _EmptyOptinsState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final heading = AppLocalizations.of(context)
        .translate("my_conversations:empty_state_heading");
    final subheading = AppLocalizations.of(context)
        .translate("my_conversations:empty_state_subeading");
    final headingStyle = Theme.of(context).textTheme.bodyText1.copyWith(
          fontSize: 18.00,
        );
    final subheadingStyle = Theme.of(context).textTheme.bodyText1.copyWith(
          fontSize: 14.00,
        );
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 640.00,
        child: Column(
          children: [
            const SizedBox(height: AppInsets.xxl),
            Image(
              image: AppImageAssets.emptyCalendar,
              width: MediaQuery.of(context).size.width * 0.8,
            ),
            const SizedBox(height: AppInsets.xl),
            Text(heading, style: headingStyle),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Text(
                subheading,
                textAlign: TextAlign.center,
                style: subheadingStyle,
              ),
            ),
          ],
        ),
      ),
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

    final primaryColor = Theme.of(context).primaryColor;
    final now = DateTime.now().toUtc();
    final isToday = now.isSameDate(date);
    final decoration = BoxDecoration(
      color: isToday ? primaryColor : Colors.transparent,
      shape: BoxShape.circle,
    );
    final dateLabelStyle = Theme.of(context).textTheme.bodyText1.copyWith(
          fontSize: isToday ? 16.00 : 18.00,
          fontWeight: FontWeight.w700,
          color: isToday ? Colors.white : Colors.grey[800],
        );
    return Padding(
      padding: const EdgeInsets.all(AppInsets.xl),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          children: [
            Text(weekDayFormat.format(date.toLocal()),
                style: weekdayLabelStyle),
            const SizedBox(height: AppInsets.sm),
            Container(
              height: 32.00,
              width: 32.00,
              decoration: decoration,
              child: Center(
                child: Text(dateFormat.format(date), style: dateLabelStyle),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
