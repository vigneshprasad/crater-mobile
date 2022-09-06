import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/core/analytics/analytics.dart';
import 'package:worknetwork/core/analytics/anlytics_events.dart';
import 'package:worknetwork/core/color/color.dart';
import 'package:worknetwork/core/widgets/root_app.dart';
import 'package:worknetwork/features/club/domain/entity/upcoming_grid_item.dart';
import 'package:worknetwork/features/conversations/domain/entity/webinar_entity/webinar_entity.dart';
import 'package:worknetwork/features/conversations/presentation/screens/conversation_screen/conversation_screen_state.dart';
import 'package:worknetwork/features/conversations/presentation/widgets/plain_button.dart';
import 'package:worknetwork/features/conversations/presentation/widgets/stream_time.dart';
import 'package:worknetwork/features/meeting/presentation/screens/dyte_meeting_screen.dart';
import 'package:worknetwork/routes.gr.dart';
import 'package:worknetwork/utils/navigation_helpers/navigate_post_auth.dart';

class GoingLiveList extends HookConsumerWidget {
  final List<UpcomingGridItem> gridItems;
  final bool showCategories;
  final String title;

  GoingLiveList({
    required this.gridItems,
    required this.title,
    this.showCategories = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.separated(
      itemCount: gridItems.length,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 100),
      itemBuilder: (context, index) {
        final c = gridItems[index];
        final image = c.conversation?.topicDetail?.image;
        final title = c.conversation?.topicDetail?.name ?? '';
        final userImage = c.conversation?.hostDetail?.photo;
        final userName = c.conversation?.hostDetail?.name ?? '';

        final items = [
          const SizedBox(
            height: 16,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Text(
              this.title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          if (showCategories)
            Column(
              children: const [
                SizedBox(
                  height: 12,
                ),
                CategoryGridView(type: GridItemType.upcoming),
              ],
            ),
          const SizedBox(
            height: 20,
          ),
        ];

        return Column(
          children: [
            if (index == 0)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: items,
              ),
            LiveListItem(item: c),
            if (index == gridItems.length - 1)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const Divider(),
                    PlainButton(
                      title: 'View All',
                      icon: Icons.arrow_forward_ios,
                      borderColor: HexColor.fromHex('#373737'),
                      onPressed: () {
                        AutoRouter.of(context).push(
                          UpcomingStreamScreenRoute(
                            categoryName: 'Going live soon',
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
          ],
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(
          height: 32,
        );
      },
    );
  }
}

class LiveListItem extends HookConsumerWidget {
  final UpcomingGridItem item;

  LiveListItem({required this.item, Key? key}) : super(key: key);

  late OverlayEntry? overlayEntry;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final webinar = item.conversation!;
    final image = webinar.topicDetail?.image;
    final title = webinar.topicDetail?.name ?? '';
    final userImage = webinar.hostDetail?.photo;
    final userName = webinar.hostDetail?.name ?? '';

    final isRsvped = useState(webinar.rsvp ?? false);

    Future<void> _requestJoinGroup() async {
      final analytics = ref.read(analyticsProvider);
      analytics.trackEvent(
        eventName: AnalyticsEvents.rsvpStreamButtonClick,
        properties: {
          "id": webinar.id,
        },
      );

      overlayEntry = buildLoaderOverlay();
      Overlay.of(context)?.insert(overlayEntry!);

      final response = await ref
          .read(conversationStateProvider(webinar.id!).notifier)
          .postRequestToJoinGroup();

      response.fold(
        (failure) {
          overlayEntry?.remove();
          Fluttertoast.showToast(msg: failure.message.toString());
        },
        (request) async {
          analytics.trackEvent(
            eventName: AnalyticsEvents.rsvpStream,
            properties: {
              "id": request.group,
            },
          );
          overlayEntry?.remove();
          isRsvped.value = true;
        },
      );
    }

    final imageWidth = MediaQuery.of(context).size.width * 0.3;
    final imageHeight = imageWidth * 68 / 114;

    return InkWell(
      onTap: () {
        if (item.type == GridItemType.live) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DyteMeetingScreen(
                conversation: webinar,
              ),
            ),
          );
        } else if (item.type == GridItemType.past) {
          AutoRouter.of(context)
              .push(PastStreamDetailScreenRoute(id: webinar.id));
        } else {
          AutoRouter.of(context).push(ConversationScreenRoute(id: webinar.id));
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Row(
              children: [
                if (image != null)
                  Image.network(
                    image,
                    height: imageHeight,
                    width: imageWidth,
                    fit: BoxFit.cover,
                  )
                else
                  const SizedBox(
                    height: 68,
                    width: 114,
                  ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          if (userImage != null)
                            CircleAvatar(
                              radius: 8,
                              backgroundImage: CachedNetworkImageProvider(
                                userImage,
                              ),
                            ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            userName,
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                StreamTime(start: webinar.start),
                const Spacer(),
                if (item.type == GridItemType.past)
                  Container()
                else if (!isRsvped.value)
                  PlainButton(
                    title: 'Remind Me',
                    icon: Icons.notifications_none,
                    borderColor: Colors.white,
                    onPressed: _requestJoinGroup,
                  )
                else
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: HexColor.fromHex('#53A476'),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Subscribed',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(color: HexColor.fromHex('#53A476')),
                          ),
                          Icon(
                            Icons.check,
                            size: 12,
                            color: HexColor.fromHex('#53A476'),
                          )
                        ],
                      ),
                    ),
                  )
              ],
            )
          ],
        ),
      ),
    );
  }
}
