import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/features/club/presentation/widgets/home_app_bar.dart';
import 'package:worknetwork/features/connection/presentation/widget/featured_list/creator_list.dart';
import 'package:worknetwork/features/connection/presentation/widget/featured_list/creator_list_state.dart';
import 'package:worknetwork/features/conversations/domain/entity/conversation_entity/conversation_entity.dart';

import '../../../../../constants/app_constants.dart';
import '../../../../../constants/theme.dart';
import '../conversation_card/conversation_card.dart';
import 'conversation_calendar_tab_state.dart';
import 'my_past_stream.dart';
import 'my_past_stream_state.dart';

const kLeftPaddingForDate = 20.00;

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
    final pastController =
        useProvider(conversationCalendarStateProvider(type).notifier);
    final creatorControlller = useProvider(creatorStateProvider('').notifier);
    final pastStreamController =
        useProvider(myPastStreamsStateProvider(null).notifier);

    return SafeArea(
        child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                const HomeAppBar(title: 'Upcoming Streams'),
              ];
            },
            body: RefreshIndicator(
                // displacement: 96.00,
                color: Theme.of(context).accentColor,
                onRefresh: () {
                  return Future.wait([
                    pastController.getInitialData(),
                    creatorControlller.getProfileList(''),
                    pastStreamController.getPastData(),
                  ]);
                },
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: _LoadedConversationTab(
                        type: type,
                        name: name,
                        onSchedulePressed: onSchedulePressed,
                        onReload: () {},
                      ),
                    ),
                    SliverToBoxAdapter(child: CreatorList()),
                    const MyPastStream(),
                  ],
                ))));
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
    final pastProvider = useProvider(conversationCalendarStateProvider(type));

    return pastProvider.when(
        loading: () => Container(),
        data: (weeks) {
          final List<Widget> children = [];

          bool emptyStateAdded = false;

          for (final week in weeks) {
            /// Add Conversations
            final List<Conversation> allConversations = [];
            week.conversations.forEach((element) {
              allConversations.addAll(element.conversations ?? []);
            });
            if (allConversations.isNotEmpty) {
              return SizedBox(
                  height: 280,
                  width: double.infinity,
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
                  ));
            }
          }

          return Container();
        },
        error: (failure, trace) => Container());
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
    return Padding(
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
    );
  }
}
