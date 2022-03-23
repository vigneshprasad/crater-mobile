import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/features/club/presentation/widgets/home_app_bar.dart';
import 'package:worknetwork/features/connection/presentation/widget/featured_list/creator_list.dart';
import 'package:worknetwork/features/connection/presentation/widget/featured_list/featured_list.dart';
import 'package:worknetwork/features/conversations/domain/entity/conversation_entity/conversation_entity.dart';

import '../../../../../constants/app_constants.dart';
import '../../../../../constants/theme.dart';
import '../conversation_card/conversation_card.dart';
import '../sliver_obstruction_injector/sliver_obstruction_injector.dart';
import 'conversation_calendar_tab_state.dart';
import 'my_past_stream.dart';

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

    return SafeArea(
      child: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: const HomeAppBar(title: 'Upcoming Streams'),
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

    bool emptyStateAdded = false;

    for (final week in weeks) {
      /// Add Conversations
      final List<Conversation> allConversations = [];
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
    }

    children.add(
       SliverToBoxAdapter(
        child: CreatorList(),
      ),
    );

    children.add(
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Text(
            'Streams you wanted to join',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      ),
    );

    children.add(const MyPastStream());

    if (children.length == 1 && emptyStateAdded == false) {
      children.add(_EmptyOptinsState());
      emptyStateAdded = true;
    }

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
