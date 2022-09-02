import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/features/club/domain/entity/upcoming_grid_item.dart';
import 'package:worknetwork/features/club/presentation/screens/streams/stream_screen_state.dart';
import 'package:worknetwork/features/club/presentation/screens/streams/upcoming_stream_screen_state.dart';
import 'package:worknetwork/features/club/presentation/widgets/home_app_bar.dart';
import 'package:worknetwork/features/conversations/presentation/widgets/plain_button.dart';
import 'package:worknetwork/features/conversations/presentation/widgets/stream_time.dart';
import 'package:worknetwork/features/meeting/presentation/screens/dyte_meeting_screen.dart';
import 'package:worknetwork/routes.gr.dart';

class UpcomingStreamScreen extends HookConsumerWidget {
  final int? categoryId;
  final String? categoryName;

  const UpcomingStreamScreen({
    this.categoryId,
    this.categoryName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clubsProvider = ref.watch(upcomingStreamsStateProvider(categoryId));
    final _controller = useScrollController();
    _controller.addListener(() {
      // reached End of scroll
      if (_controller.offset >= _controller.position.maxScrollExtent &&
          !_controller.position.outOfRange) {
        ref
            .read(upcomingStreamsStateProvider(categoryId).notifier)
            .getNextPageList();
      }
    });
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, isexpanded) {
            return [
              HomeAppBar(
                title: categoryName ?? 'Going live soon',
                leftPadding: categoryId == null ? null : 50,
              )
            ];
          },
          body: RefreshIndicator(
            color: Theme.of(context).colorScheme.secondary,
            onRefresh: () {
              final futures = [
                ref.read(streamStateProvider.notifier).getUpcomingData(),
              ];

              return Future.wait(futures);
            },
            child: clubsProvider.when(
              loading: () => Container(),
              error: (e, s) => Container(),
              data: (gridItems) {
                if (gridItems.isEmpty) {
                  return Center(child: Text('Coming soon...'));
                }
                return ListView.separated(
                  itemCount: gridItems.length,
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
                      ),
                      const CategoryGridView(type: GridItemType.upcoming),
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
                        InkWell(
                          onTap: () {
                            AutoRouter.of(context).push(
                              ConversationScreenRoute(id: c.conversation?.id),
                            );
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
                                        height: 68,
                                        width: 114,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            title,
                                            maxLines: 2,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Row(
                                            children: [
                                              if (userImage != null)
                                                CircleAvatar(
                                                  radius: 8,
                                                  backgroundImage:
                                                      CachedNetworkImageProvider(
                                                    userImage,
                                                  ),
                                                ),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              Text(
                                                userName,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption,
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
                                    StreamTime(start: c.conversation?.start),
                                    const Spacer(),
                                    PlainButton(
                                      title: 'Remind Me',
                                      icon: Icons.notifications_none,
                                      borderColor: Colors.white,
                                      onPressed: () {},
                                    ),
                                  ],
                                )
                              ],
                            ),
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
              },
            ),
          ),
        ),
      ),
    );
  }
}
