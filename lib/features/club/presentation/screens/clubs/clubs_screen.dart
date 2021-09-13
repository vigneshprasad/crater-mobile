import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/core/color/color.dart';
import 'package:worknetwork/features/club/presentation/screens/clubs/clubs_screen_state.dart';
import 'package:worknetwork/features/conversations/domain/entity/conversation_entity/conversation_entity.dart';
import 'package:worknetwork/routes.gr.dart';
import 'package:timeago/timeago.dart' as timeago;

class ClubsScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final _scrollController = useScrollController();
    final clubsProvider = useProvider(clubsStateProvider);

    final _tab = useState(0);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            MaterialButton(
                onPressed: () {
                  _tab.value = 0;
                  const offset = 0.0;
                  _scrollController.animateTo(offset,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Live'),
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      width: 20,
                      height: 1,
                      color:
                          _tab.value == 0 ? HexColor.fromHex('#9146FF') : null,
                    )
                  ],
                )),
            MaterialButton(
                onPressed: () {
                  _tab.value = 1;
                  const offset = 400.0;
                  _scrollController.animateTo(offset,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Upcoming'),
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      width: 20,
                      height: 1,
                      color:
                          _tab.value == 1 ? HexColor.fromHex('#9146FF') : null,
                    )
                  ],
                )),
          ],
        ),
      ),
      body: clubsProvider.when(
          loading: () => Container(),
          error: (e, s) => Container(),
          data: (conversations) {
            final liveItems = conversations
                .map((e) => UpcomingGridItem(
                      conversation: e,
                      type: GridItemType.live,
                    ))
                .toList();
            final upcomingItems = conversations
                .map((e) => UpcomingGridItem(
                      conversation: e,
                      type: GridItemType.upcoming,
                    ))
                .toList();
            upcomingItems.insert(
                1,
                UpcomingGridItem(
                    title: 'UPCOMING\nSTREAMS',
                    color: '#B02A2A',
                    type: GridItemType.title,
                    icon: const Icon(
                      Icons.schedule,
                      size: 80,
                    )));

            upcomingItems.insert(
                upcomingItems.length,
                UpcomingGridItem(
                    title: 'PAST\nSTREAMS',
                    color: '#80D1C3',
                    type: GridItemType.title,
                    icon: const Icon(
                      Icons.movie,
                      size: 80,
                    )));

            final pastItems = conversations
                .map((e) => UpcomingGridItem(
                      conversation: e,
                      type: GridItemType.past,
                    ))
                .toList();

            final items = liveItems;
            items.addAll(upcomingItems);
            items.addAll(pastItems);
            return StaggeredGridView.countBuilder(
              padding: const EdgeInsets.all(8),
              crossAxisCount: 2,
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                switch (items[index].type) {
                  case GridItemType.title:
                    return UpcomingGridTitleTile(items[index]);
                  default:
                    return UpcomingGridTile(items[index]);
                }
              },
              staggeredTileBuilder: (int index) {
                switch (items[index].type) {
                  case GridItemType.upcoming:
                    return const StaggeredTile.count(1, 1.5);
                  case GridItemType.title:
                    return const StaggeredTile.count(1, 0.75);
                  default:
                    return const StaggeredTile.count(2, 1.5);
                }
              },
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
            );
          }),
    );
  }
}

class UpcomingGridTitleTile extends StatelessWidget {
  final UpcomingGridItem item;
  const UpcomingGridTitleTile(
    this.item, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(8),
        color: HexColor.fromHex(item.color ?? '#000000'),
        child: Center(
          child: Column(
            children: [
              item.icon!,
              const SizedBox(height: 8),
              Text(
                item.title ?? '',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    ?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum GridItemType {
  live,
  title,
  upcoming,
  past,
}

class UpcomingGridItem {
  final Conversation? conversation;
  final String? title;
  final Icon? icon;
  final String? color;
  final GridItemType type;

  UpcomingGridItem({
    this.conversation,
    this.title,
    this.icon,
    this.color,
    required this.type,
  });
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
                        if (user?.photo != null)
                          Image.network(
                            user?.photo ?? '',
                            height: double.infinity,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        if (item.type == GridItemType.upcoming)
                          Positioned(
                            right: 10,
                            top: 10,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: HexColor.fromHex('#9146FF'),
                              ),
                              child: Text(
                                timeago
                                    .format(conversation.start!,
                                        locale: 'en_short', allowFromNow: true)
                                    .toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ),
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
                            backgroundColor:
                                Theme.of(context).dialogBackgroundColor,
                          ),
                        ),
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    user?.name ?? '',
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                    maxLines: 2,
                                  ),
                                ),
                                const SizedBox(width: 8),
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
                            const SizedBox(height: 4),
                            Text(
                              topic?.articleDetail?.title ?? '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            )
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

class LiveGridTile extends StatelessWidget {
  final GridItemType type;
  const LiveGridTile(
    this.type, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).dialogBackgroundColor.withAlpha(50),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/img_drawer_image.png',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  if (type == GridItemType.live)
                    Container(
                      margin: const EdgeInsets.only(top: 8, left: 12),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.red,
                      ),
                      child: Text('LIVE'),
                    ),
                  if (type == GridItemType.past)
                    Center(
                      child: Icon(Icons.play_circle, size: 80),
                    )
                ],
              ),
            ),
            ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              title: const Text('Vivan Puri'),
              subtitle: const Text(
                'lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum ',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              leading: const CircleAvatar(
                backgroundColor: Colors.black,
              ),
              trailing: Chip(
                visualDensity: VisualDensity.compact,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                label: const Text(
                  'Marketing',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.transparent,
                side: const BorderSide(color: Colors.white),
              ),
            ),
          ],
        ));
  }
}
