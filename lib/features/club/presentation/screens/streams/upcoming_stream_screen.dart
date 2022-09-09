import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/features/club/domain/entity/upcoming_grid_item.dart';
import 'package:worknetwork/features/club/presentation/screens/streams/past_stream_screen_state.dart';
import 'package:worknetwork/features/club/presentation/screens/streams/upcoming_stream_screen_state.dart';
import 'package:worknetwork/features/club/presentation/widgets/going_live_list.dart';
import 'package:worknetwork/features/club/presentation/widgets/home_app_bar.dart';
import 'package:worknetwork/features/meeting/presentation/screens/dyte_meeting_screen.dart';

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
    final pastStreamProvider = ref.watch(pastStreamsStateProvider(categoryId));
    final _controller = useScrollController();
    _controller.addListener(() {
      // reached End of scroll
      if (_controller.offset >= _controller.position.maxScrollExtent &&
          !_controller.position.outOfRange) {
        ref
            .read(upcomingStreamsStateProvider(categoryId).notifier)
            .getNextPageList();
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
                title: categoryName ?? 'Going live soon',
                leftPadding: categoryName == null ? null : 50,
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 16),
              ),
              SliverToBoxAdapter(
                child: CategoryGridView(
                  type: GridItemType.upcoming,
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
                    .read(upcomingStreamsStateProvider(categoryId).notifier)
                    .getUpcomingData(),
                ref
                    .read(pastStreamsStateProvider(categoryId).notifier)
                    .getPastData(),
              ];

              return Future.wait(futures);
            },
            child: clubsProvider.when(
              loading: () => Container(),
              error: (e, s) => Container(),
              data: (upcomingItems) {
                return pastStreamProvider.when(
                  loading: () => Container(),
                  error: (e, s) => Container(),
                  data: (pastItems) {
                    const upcomingTitle = UpcomingGridItem(
                      type: GridItemType.title,
                      title: 'Upcoming streams',
                    );
                    const title = UpcomingGridItem(
                      type: GridItemType.title,
                      title: 'Past streams',
                    );
                    final gridItems =
                        [upcomingTitle] + upcomingItems + [title] + pastItems;
                    if (gridItems.isEmpty) {
                      return const Center(child: Text('Coming soon...'));
                    }
                    return ListView.separated(
                      itemCount: gridItems.length,
                      padding: const EdgeInsets.only(bottom: 100),
                      itemBuilder: (context, index) {
                        final c = gridItems[index];

                        if (c.type == GridItemType.title) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 32.0, left: 16),
                            child: Text(
                              c.title ?? '',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          );
                        }

                        final image = c.conversation?.topicDetail?.image;
                        final title = c.conversation?.topicDetail?.name ?? '';
                        final userImage = c.conversation?.hostDetail?.photo;
                        final userName = c.conversation?.hostDetail?.name ?? '';

                        final items = [
                          const SizedBox(
                            height: 16,
                          ),
                          CategoryGridView(
                            type: GridItemType.upcoming,
                            selectedId: categoryId,
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
                          ],
                        );
                      },
                      separatorBuilder: (context, index) {
                        if (gridItems[index].type == GridItemType.title) {
                          return SizedBox(
                            height: 20,
                          );
                        }
                        return const Divider(
                          height: 32,
                        );
                      },
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
