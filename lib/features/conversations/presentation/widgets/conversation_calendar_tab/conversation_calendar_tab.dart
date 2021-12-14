import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:worknetwork/core/features/share_manager/share_manager.dart';
import 'package:worknetwork/features/club/presentation/widgets/home_app_bar.dart';
import 'package:worknetwork/features/conversations/domain/entity/conversation_entity/conversation_entity.dart';
import 'package:worknetwork/features/meeting/presentation/widgets/meeting_request_card.dart';

import '../../../../../constants/app_constants.dart';
import '../../../../../constants/theme.dart';
import '../../../../../core/extensions/date_time_extensions.dart';
import '../../../../../routes.gr.dart';
import '../../../../../ui/base/base_large_button/base_large_button.dart';
import '../../../../meeting/presentation/widgets/oneonone_card.dart';
import '../conversation_card/conversation_card.dart';
import '../optin_card/optin_card.dart';
import '../sliver_obstruction_injector/sliver_obstruction_injector.dart';
import 'conversation_calendar_tab_state.dart';

const kLeftPaddingForDate = 20.00;

final homeScreenScrollController =
    Provider.autoDispose<ScrollController>((ref) {
  final controller = ScrollController();
  ref.onDispose(() {
    controller.dispose();
  });
  return controller;
});

class ConversationCalendarTab extends HookWidget {
  final ConversationTabType type;
  final String name;
  final VoidCallback onSchedulePressed;

  const ConversationCalendarTab({
    required this.type,
    required this.name,
    required this.onSchedulePressed,
  });

  @override
  Widget build(BuildContext context) {
    final intialState = useProvider(initialStateProvider(type));
    final _scrollController = useProvider(homeScreenScrollController);
    final shareManager = useProvider(shareManagerProvider);

    return SafeArea(
      child: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: const HomeAppBar(title: 'Streams'),
              ),
            ];
          },
          body: DefaultStickyHeaderController(
              child: intialState.when(
            loading: () => Center(
                child: CircularProgressIndicator(
              color: Theme.of(context).accentColor,
            )),
            data: (results) => _LoadedConversationTab(
              type: type,
              name: name,
              onSchedulePressed: onSchedulePressed,
              onReload: () {},
            ),
            error: (err, st) => _Loader(message: err.toString()),
          ))),
    );
  }
}

class _Loader extends StatelessWidget {
  final String message;

  const _Loader({Key? key, required this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(message));
  }
}

class _LoadedConversationTab extends HookWidget {
  final ConversationTabType type;
  final String name;
  final VoidCallback onSchedulePressed;
  final VoidCallback onReload;

  const _LoadedConversationTab({
    Key? key,
    required this.type,
    required this.name,
    required this.onSchedulePressed,
    required this.onReload,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller =
        useProvider(conversationCalendarStateProvider(type).notifier);
    final weeks = useProvider(conversationCalendarStateProvider(type));

    final List<Widget> children = [];

    children.add(SliverObstructionInjector(
      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
    ));

    if (type == ConversationTabType.all) {
      children.add(SliverToBoxAdapter(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              name,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 8),
            const Text(
              'You can join upcoming conversations here',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      )));
    }

    bool emptyStateAdded = false;

    for (final week in weeks) {
      /// Add 1:1 Meetings
      for (final date in week.meetings) {
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
                top: 60,
              ),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return OneOnOneCard(meeting: date.meetings![index]);
                  },
                  childCount: date.meetings?.length,
                ),
              ),
            ),
          ),
        ]);
      }
      bool oneOnOneTitleAdded = false;
      for (final date in week.requests) {
        if (!oneOnOneTitleAdded) {
          oneOnOneTitleAdded = true;
          children.add(
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 40.0),
                child: AccentTitle(title: '1:1 Conversations'),
              ),
            ),
          );
        }
        children.addAll([
          SliverStickyHeader.builder(
            overlapsContent: true,
            builder: (context, state) {
              return _DateLabel(date: date.date);
            },
            sliver: SliverPadding(
              padding: const EdgeInsets.only(
                left: kLeftPaddingForDate,
                bottom: AppInsets.sm,
                top: 60,
              ),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return MeetingRequestCard(
                        onCardPressed: () async {
                          await AutoRouter.of(context).push(
                              MeetingRequestDetailScreenRoute(
                                  meetingId:
                                      date.meetingsRequests![index].id!));
                          onReload();
                        },
                        meeting: date.meetingsRequests![index]);
                  },
                  childCount: date.meetingsRequests?.length,
                ),
              ),
            ),
          ),
        ]);
      }
      if (week.future != null) {
        /// Add Conversations
        List<Conversation> allConversations = [];
        week.conversations.forEach((element) {
          allConversations.addAll(element.conversations ?? []);
        });
        if (allConversations.isNotEmpty) {
          children.add(
            SliverToBoxAdapter(
              child: SizedBox(
                  height: 280,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          height: 280.0,
                          enlargeCenterPage: true,
                          enableInfiniteScroll: false,
                        ),
                        items: allConversations.map((c) {
                          return Builder(
                            builder: (BuildContext context) {
                              return ConversationCard(conversation: c);
                            },
                          );
                        }).toList(),
                      ),
                    ],
                  )),
            ),
          );
        }
      } else {
        if (week.optins.isEmpty) {
          if (emptyStateAdded == false) {
            children.add(_EmptyOptinsState());
            emptyStateAdded = true;
          }
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
                    top: 60,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final optin = date.optins![index];
                        return OptinCard(optin: optin);
                      },
                      childCount: date.optins?.length,
                    ),
                  ),
                ),
              ),
            ]);
          }
        }
      }
    }

    if (children.length == 1 && emptyStateAdded == false) {
      children.add(_EmptyOptinsState());
      emptyStateAdded = true;
    }
    // if (children.length == 1) {
    //   children.add(const SliverToBoxAdapter(
    //     child: SizedBox(
    //       height: 300,
    //     ),
    //   ));
    // }

    children.add(SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: SizedBox(
          width: double.infinity,
          child: BaseLargeButton(
            onPressed: onSchedulePressed,
            text: 'Network with peers',
          ),
        ),
      ),
    ));

    return RefreshIndicator(
      // displacement: 96.00,
      color: Theme.of(context).accentColor,
      onRefresh: () {
        return controller.getInitialData();
      },
      child: CustomScrollView(
        slivers: [
          const SliverPadding(padding: EdgeInsets.only(bottom: 20.00)),
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
    const heading = 'Upcoming conversations';
    const subheading =
        'You have no upcoming conversations. At crater you can a curated set of peers for live 1:1 conversations. All you have to do is opt-in';
    final headingStyle = Theme.of(context).textTheme.headline6;
    final subheadingStyle = Theme.of(context).textTheme.bodyText2;
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppInsets.xxl),
            const Image(
              image: AppImageAssets.meetingScheduled,
            ),
            const SizedBox(height: AppInsets.xxl),
            Text(heading, style: headingStyle),
            const SizedBox(height: AppInsets.xxl),
            Text(
              subheading,
              style: subheadingStyle,
            ),
          ],
        ),
      ),
    );
  }
}

class _DateLabel extends StatelessWidget {
  final DateTime? date;

  const _DateLabel({
    Key? key,
    this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (date == null) return Container();
    final dateFormat = DateFormat("d MMM - yyyy");
    final primaryColor = Theme.of(context).scaffoldBackgroundColor;
    final now = DateTime.now().toUtc();
    final isToday = now.isSameDate(date!);
    final decoration = BoxDecoration(
        color: primaryColor, borderRadius: BorderRadius.circular(20));
    final dateLabelStyle = Theme.of(context).textTheme.bodyText1?.copyWith(
          fontSize: isToday ? 16.00 : 18.00,
          color: isToday ? Colors.white : Colors.white70,
        );
    return Padding(
      padding: const EdgeInsets.all(AppInsets.xl),
      child: Align(
        child: Column(
          children: [
            Container(
              height: 30.00,
              width: 200.00,
              decoration: decoration,
              child: Center(
                child: Text(dateFormat.format(date!), style: dateLabelStyle),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
