import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/features/club/domain/entity/upcoming_grid_item.dart';
import 'package:worknetwork/features/club/presentation/screens/streams/past_stream_screen_state.dart';
import 'package:worknetwork/features/club/presentation/widgets/home_app_bar.dart';
import 'package:worknetwork/features/club/presentation/widgets/upcoming_grid_tile.dart';
import 'package:worknetwork/features/club/presentation/widgets/upcoming_grid_title_tile.dart';
import 'package:worknetwork/features/conversations/presentation/widgets/stream_time.dart';
import 'package:worknetwork/features/meeting/presentation/screens/dyte_meeting_screen.dart';
import 'package:worknetwork/routes.gr.dart';

class PastStreamScreen extends HookConsumerWidget {
  final int? categoryId;
  final String? categoryName;

  const PastStreamScreen({this.categoryId, this.categoryName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pastStreamProvider = ref.watch(pastStreamsStateProvider(categoryId));

    final _controller = useScrollController();
    _controller.addListener(() {
      // reached End of scroll
      if (_controller.offset >= _controller.position.maxScrollExtent &&
          !_controller.position.outOfRange) {
        ref
            .read(pastStreamsStateProvider(categoryId).notifier)
            .getNextPageConnectableProfileList();
      }
    });
    return Scaffold(
      body: SafeArea(
          child: NestedScrollView(
              headerSliverBuilder: (context, isexpanded) {
                return [
                  HomeAppBar(
                    title: categoryName ?? 'Past Streams',
                    leftPadding: categoryName == null ? null : 50,
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 16),
                  ),
                  SliverToBoxAdapter(
                    child: CategoryGridView(
                      type: GridItemType.past,
                      selectedId: categoryId,
                    ),
                  ),
                ];
              },
              body: RefreshIndicator(
                  color: Theme.of(context).colorScheme.secondary,
                  onRefresh: () {
                    final futures = [
                      ref
                          .read(pastStreamsStateProvider(categoryId).notifier)
                          .getPastData(),
                    ];

                    return Future.wait(futures);
                  },
                  child: pastStreamProvider.when(
                    loading: () => Container(),
                    error: (e, s) => Container(),
                    data: (streams) {
                      final gridItems = streams;
                      return ListView.separated(
                        controller: _controller,
                        itemCount: gridItems.length,
                        padding: const EdgeInsets.only(
                          bottom: 100,
                          top: 20,
                        ),
                        itemBuilder: (context, index) {
                          final c = gridItems[index];
                          final image = c.conversation?.topicDetail?.image;
                          final title = c.conversation?.topicDetail?.name ?? '';
                          final userImage = c.conversation?.hostDetail?.photo;
                          final userName =
                              c.conversation?.hostDetail?.name ?? '';

                          return InkWell(
                            onTap: () {
                              AutoRouter.of(context).navigate(
                                PastStreamDetailScreenRoute(
                                  id: c.conversation?.id,
                                ),
                              );
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
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
                                    height: 16,
                                  ),
                                  Row(
                                    children: [
                                      StreamTime(start: c.conversation?.start),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider(
                            height: 32,
                          );
                        },
                      );
                    },
                  )))),
    );
  }
}

class _PastStreamScreen extends HookConsumerWidget {
  final int? categoryId;
  final String? categoryName;

  const _PastStreamScreen({this.categoryId, this.categoryName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pastStreamProvider = ref.watch(pastStreamsStateProvider(categoryId));

    final _controller = useScrollController();
    _controller.addListener(() {
      // reached End of scroll
      if (_controller.offset >= _controller.position.maxScrollExtent &&
          !_controller.position.outOfRange) {
        ref
            .read(pastStreamsStateProvider(categoryId).notifier)
            .getNextPageConnectableProfileList();
      }
    });

    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, isexpanded) {
            return [
              HomeAppBar(
                title: categoryName ?? 'Past Streams',
                leftPadding: categoryId == null ? null : 50,
              )
            ];
          },
          body: RefreshIndicator(
            color: Theme.of(context).colorScheme.secondary,
            onRefresh: () {
              final futures = [
                ref
                    .read(pastStreamsStateProvider(categoryId).notifier)
                    .getPastData(),
              ];

              return Future.wait(futures);
            },
            child: pastStreamProvider.when(
              loading: () => Container(),
              error: (e, s) => Container(),
              data: (streams) {
                return ListView.separated(
                  controller: _controller,
                  padding: const EdgeInsets.only(
                    top: 8,
                    left: 8,
                    right: 8,
                    bottom: 80,
                  ),
                  itemCount: streams.length,
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 20,
                    );
                  },
                  itemBuilder: (BuildContext context, int index) {
                    final upIndex = index;

                    switch (streams[upIndex].type) {
                      case GridItemType.title:
                        return SizedBox(
                          width: double.infinity,
                          height: 100,
                          child: UpcomingGridTitleTile(streams[upIndex]),
                        );
                      case GridItemType.loader:
                        return SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        );
                      default:
                        return Column(
                          children: [
                            if (index == 0 && categoryId == null)
                              const CategoryGridView(type: GridItemType.past),
                            AspectRatio(
                              aspectRatio: 4.0 / 3.0,
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0,
                                ),
                                child: UpcomingGridTile(streams[upIndex]),
                              ),
                            ),
                          ],
                        );
                    }
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
