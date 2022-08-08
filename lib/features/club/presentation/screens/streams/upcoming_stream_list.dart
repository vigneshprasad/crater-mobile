import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/core/analytics/analytics.dart';
import 'package:worknetwork/core/analytics/anlytics_events.dart';
import 'package:worknetwork/features/club/presentation/screens/streams/stream_screen.dart';
import 'package:worknetwork/features/club/presentation/screens/streams/upcoming_stream_list_state.dart';
import 'package:worknetwork/ui/base/base_large_button/base_large_button.dart';

class UpcomingStreamList extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clubsProvider = ref.watch(upcomingStreamListStateProvider);

    final _controller = useScrollController();
    _controller.addListener(() {
      // reached End of scroll
      if (_controller.offset >= _controller.position.maxScrollExtent &&
          !_controller.position.outOfRange) {
        ref.read(upcomingStreamListStateProvider.notifier).getNextPageData();
      }
    });

    return clubsProvider.when(
      loading: () => Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      error: (err, st) => Center(
        child: err == null ? Container() : Text(err.toString()),
      ),
      data: (streams) {
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Live & Upcoming Streams',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return SizedBox(
                    height: 320,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: WebinarCard(
                        streams[index],
                      ),
                    ),
                  );
                },
                childCount: streams.length,
              ),
            ),
            const SliverPadding(padding: EdgeInsets.all(20)),
          ],
        );
      },
    );
  }
}

class WebinarCard extends HookConsumerWidget {
  final UpcomingGridItem item;
  WebinarCard(
    this.item, {
    Key? key,
  }) : super(key: key);

  late ValueNotifier<bool> isRSVPed;
  late WidgetRef ref;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    this.ref = ref;
    final conversation = item.conversation!;
    final user = conversation.hostDetail;
    final topic = conversation.topicDetail;
    String description = user?.introduction ?? topic?.name ?? ' ';
    if (description.isEmpty) {
      description = item.conversation?.description ?? '';
    }
    final title = user?.name ?? '';

    isRSVPed = useState(item.conversation?.rsvp ?? false);

    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(12),
      child: GridTile(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(user?.photo ?? ''),
                      backgroundColor: Theme.of(context).dialogBackgroundColor,
                      radius: 20,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                title,
                                style: Theme.of(context).textTheme.subtitle2,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  color: Theme.of(context).dialogBackgroundColor,
                  width: double.infinity,
                  height: double.infinity,
                  child: Stack(
                    children: [
                      if (topic?.image != null)
                        Image.network(
                          topic?.image ?? '',
                          height: double.infinity,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      if (item.type == GridItemType.upcoming)
                        LiveTime(date: item.conversation?.start?.toLocal()),
                      if (item.type == GridItemType.past)
                        const Center(
                          child: Icon(Icons.play_circle, size: 80),
                        ),
                      if (item.type == GridItemType.live)
                        Container(
                          margin: const EdgeInsets.only(top: 8, left: 12),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.red,
                          ),
                          child: const Text('LIVE'),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: SizedBox(
                // width: 100,
                // height: 30,
                child: isRSVPed.value
                    ? Center(
                        child: Text(
                          "RSVP'd",
                          style: Theme.of(context).textTheme.caption,
                        ),
                      )
                    : BaseLargeButton(
                        text: 'Remind me',
                        onPressed: () => _requestJoinGroup(context),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _requestJoinGroup(BuildContext context) async {
    final analytics = ref.read(analyticsProvider);
    analytics.trackEvent(
      eventName: AnalyticsEvents.rsvpStreamButtonClick,
      properties: {
        "id": item.conversation?.id,
      },
    );

    final response = await ref
        .read(upcomingStreamListStateProvider.notifier)
        .postRequestToJoinGroup(item.conversation!.id!);

    response.fold(
      (failure) {
        Fluttertoast.showToast(msg: failure.message.toString());
      },
      (request) {
        analytics.trackEvent(
          eventName: AnalyticsEvents.rsvpStream,
          properties: {
            "id": request.group,
          },
        );
        isRSVPed.value = true;
      },
    );
  }
}
