import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/features/club/domain/entity/upcoming_grid_item.dart';
import 'package:worknetwork/features/club/presentation/widgets/live_time.dart';
import 'package:worknetwork/features/meeting/presentation/screens/dyte_meeting_screen.dart';
import 'package:worknetwork/routes.gr.dart';

class LiveGridTile extends HookConsumerWidget {
  final UpcomingGridItem item;
  const LiveGridTile(
    this.item, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final conversation = item.conversation!;
    final user = conversation.hostDetail;
    final topic = conversation.topicDetail;
    final tag = topic?.root;
    String description = user?.introduction ?? topic?.name ?? ' ';
    if (description.isEmpty) {
      description = item.conversation?.description ?? '';
    }
    final title = user?.name ?? '';

    return InkWell(
      onTap: () async {
        // final link =
        //     'https://penitence-pre-prod.vercel.app/session/${conversation.id}';

        // launch(link,
        //     option: const CustomTabsOption(
        //         enableDefaultShare: false,
        //         enableInstantApps: false,
        //         enableUrlBarHiding: true,
        //         showPageTitle: false,
        //         toolbarColor: Colors.black));
        // Navigator.of(context).push(MaterialPageRoute(
        //     builder: (context) => WebinarScreen(
        //           webUrl: link,
        //         )));

        if (item.type == GridItemType.live) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DyteMeetingScreen(
                conversation: conversation,
              ),
            ),
          );
        } else {
          AutoRouter.of(context)
              .push(ConversationScreenRoute(id: conversation.id));
        }
      },
      borderRadius: BorderRadius.circular(0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(0),
        child: GridTile(
          child: Container(
            color: Theme.of(context).dialogBackgroundColor,
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
                        if (item.type == GridItemType.featured)
                          LiveTime(date: item.conversation?.start?.toLocal()),
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
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(user?.photo ?? ''),
                                    backgroundColor:
                                        Theme.of(context).dialogBackgroundColor,
                                    radius: 16,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    title,
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                    maxLines: 2,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                if (tag?.name?.isNotEmpty ?? false)
                                  Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
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
                            const SizedBox(height: 8),
                            Text(
                              description,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.caption,
                            )
                          ],
                        ),
                      ),
                    ],
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
