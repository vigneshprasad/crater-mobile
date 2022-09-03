import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:worknetwork/core/color/color.dart';
import 'package:worknetwork/features/club/domain/entity/upcoming_grid_item.dart';
import 'package:worknetwork/features/club/presentation/widgets/live_time.dart';
import 'package:worknetwork/features/conversations/presentation/widgets/plain_button.dart';
import 'package:worknetwork/features/conversations/presentation/widgets/stream_time.dart';
import 'package:worknetwork/features/meeting/presentation/screens/dyte_meeting_screen.dart';
import 'package:worknetwork/routes.gr.dart';

class PastLiveGridTile extends StatelessWidget {
  final UpcomingGridItem item;
  const PastLiveGridTile(
    this.item, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final conversation = item.conversation!;
    final user = conversation.hostDetail;
    final topic = conversation.topicDetail;
    final tag = topic?.root;
    String description = user?.introduction ?? topic?.name ?? ' ';
    if (description.isEmpty) {
      description = item.conversation?.description ?? '';
    }
    final title = user?.name ?? '';

    void buttonAction() {
      // if (kDebugMode) {
      //   Navigator.of(context).push(
      //     MaterialPageRoute(
      //       builder: (context) => DyteMeetingScreen(
      //         conversation: conversation,
      //       ),
      //     ),
      //   );
      //   return;
      // }
      if (item.type == GridItemType.live) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DyteMeetingScreen(
              conversation: conversation,
            ),
          ),
        );
      } else if (item.type == GridItemType.past) {
        AutoRouter.of(context)
            .push(PastStreamDetailScreenRoute(id: conversation.id));
      } else {
        AutoRouter.of(context)
            .push(ConversationScreenRoute(id: conversation.id));
      }
    }

    return InkWell(
      onTap: buttonAction,
      borderRadius: BorderRadius.circular(0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(0),
        child: GridTile(
          child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).dialogBackgroundColor,
                border: Border.all(
                  color: HexColor.fromHex('#1C1C1E'),
                )),
            child: Stack(
              children: [
                Container(
                  color: Theme.of(context).dialogBackgroundColor,
                  width: double.infinity,
                  height: 168,
                  child: Stack(
                    children: [
                      if (topic?.image != null)
                        Image.network(
                          topic?.image ?? '',
                          height: double.infinity,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      // const Center(
                      //   child: Icon(
                      //     Icons.play_circle,
                      //     size: 60,
                      //   ),
                      // ),
                      // WebinarVideoPlayer(
                      //     key: Key(item.conversation!.id.toString()),
                      //     conversation: item.conversation!),
                      if (item.type == GridItemType.featured)
                        LiveTime(date: item.conversation?.start?.toLocal()),
                      if (item.type == GridItemType.past)
                        Container(
                          margin: const EdgeInsets.only(top: 8, left: 12),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          child: const Text('Previously LIVE'),
                        ),
                      if (item.type == GridItemType.live)
                        Container(
                          margin: const EdgeInsets.only(top: 8, left: 12),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            color: Colors.red,
                          ),
                          child: const Text('LIVE '),
                        ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          HexColor.fromHex('#121212').withAlpha(0),
                          HexColor.fromHex('#121212'),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [
                          0,
                          0.5,
                        ]),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 12),
                                          child: CircleAvatar(
                                            backgroundImage:
                                                NetworkImage(user?.photo ?? ''),
                                            backgroundColor: Theme.of(context)
                                                .dialogBackgroundColor,
                                            radius: 16,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            title,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2,
                                            maxLines: 2,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        if (tag?.name?.isNotEmpty ?? false)
                                          Container(
                                            padding: const EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              border: Border.all(
                                                color: Colors.white,
                                                width: 0.5,
                                              ),
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
                                    const SizedBox(height: 16),
                                    Text(
                                      description,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    StreamTime(start: conversation.start),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              PlainButton(
                                title: (item.type == GridItemType.live)
                                    ? 'Join Stream'
                                    : 'Watch Stream',
                                onPressed: buttonAction,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
