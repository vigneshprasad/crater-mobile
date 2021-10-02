import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/features/club/presentation/screens/clubs/clubs_screen.dart';
import 'package:worknetwork/features/profile/presentation/screens/profile_screen/profile_screen.dart';
import 'package:worknetwork/features/profile/presentation/screens/profile_screen/profile_streams_state.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../../routes.gr.dart';

class ProfileStreamsTab extends HookWidget {
  final String userId;
  const ProfileStreamsTab(this.userId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final liveProvider = useProvider(profileLiveStreamsStateProvider(userId));
    final upcomingProvider =
        useProvider(profileUpcomingStreamsStateProvider(userId));
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            const SizedBox(height: AppInsets.xxl),
            liveProvider.when(
                loading: () => Container(),
                error: (e, s) => Container(),
                data: (conversations) {
                  if (conversations.isEmpty) return Container();
                  return SizedBox(
                      height: 350,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const UnderlinedText(
                            'LIVE',
                            bgText: 'STREAMS',
                          ),
                          const SizedBox(height: AppInsets.xl),
                          SizedBox(
                            height: 300,
                            child: UpcomingGridTile(conversations[0]),
                          ),
                        ],
                      ));
                }),
            const SizedBox(height: 40),
            upcomingProvider.when(
                loading: () => Container(),
                error: (e, s) => Container(),
                data: (conversations) {
                  if (conversations.isEmpty) return Container();
                  return SizedBox(
                      height: 300,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const UnderlinedText(
                            'UPCOMING',
                            bgText: 'STREAMS',
                          ),
                          const SizedBox(height: AppInsets.xl),
                          CarouselSlider(
                            options: CarouselOptions(
                              height: 250.0,
                              enlargeCenterPage: true,
                              enableInfiniteScroll: false,
                            ),
                            items: conversations.map((c) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return UpcomingGridTile(c);
                                },
                              );
                            }).toList(),
                          ),
                        ],
                      ));
                }),
          ],
        ),
      ),
    );
  }
}

class UpcomingGridTile extends StatelessWidget {
  final UpcomingGridItem item;
  const UpcomingGridTile(
    this.item, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final conversation = item.conversation!;
    final user = conversation.hostDetail;
    final topic = conversation.topicDetail;
    final tag = topic?.root;
    String description = topic?.name ?? ' ';
    if (description.isEmpty) {
      description = item.conversation?.description ?? '';
    }
    return InkWell(
        onTap: () {
          AutoRouter.of(context)
              .push(ConversationScreenRoute(id: conversation.id));
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: GridTile(
              child: Container(
            color: Theme.of(context).dialogBackgroundColor.withAlpha(50),
            child: Column(
              children: [
                Expanded(
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
                        if (item.type == GridItemType.live)
                          Container(
                            margin: const EdgeInsets.only(top: 8, left: 12),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.red,
                            ),
                            child: const Text('LIVE'),
                          ),
                        if (item.type == GridItemType.past)
                          const Center(
                            child: Icon(Icons.play_circle, size: 80),
                          )
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      if (item.type != GridItemType.upcoming)
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(user?.photo ?? ''),
                            backgroundColor:
                                Theme.of(context).dialogBackgroundColor,
                          ),
                        ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 4),
                            Text(
                              description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              children: [
                                if (item.type == GridItemType.upcoming)
                                  Text(
                                    timeago
                                        .format(conversation.start!,
                                            locale: 'en', allowFromNow: true)
                                        .replaceAll('from now', ''),
                                    style: Theme.of(context).textTheme.button,
                                    maxLines: 2,
                                  ),
                                const SizedBox(width: 8),
                                if (tag?.name?.isNotEmpty ?? false)
                                  Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                          color: Colors.white, width: 0.5),
                                    ),
                                    child: Text(
                                      tag?.name ?? '',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
        ));
  }
}
