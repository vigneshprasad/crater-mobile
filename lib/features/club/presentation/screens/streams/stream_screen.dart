import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/features/club/domain/entity/upcoming_grid_item.dart';
import 'package:worknetwork/features/club/presentation/screens/streams/stream_screen_state.dart';
import 'package:worknetwork/features/club/presentation/widgets/home_app_bar.dart';
import 'package:worknetwork/features/club/presentation/widgets/live_grid_tile.dart';
import 'package:worknetwork/features/club/presentation/widgets/past_live_grid_tile.dart';
import 'package:worknetwork/features/club/presentation/widgets/series_grid_tile.dart';
import 'package:worknetwork/features/club/presentation/widgets/upcoming_grid_tile.dart';
import 'package:worknetwork/features/club/presentation/widgets/upcoming_grid_title_tile.dart';

class StreamTab extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clubsProvider = ref.watch(streamStateProvider);

    final _controller = useScrollController();
    _controller.addListener(() {
      // reached End of scroll
      if (_controller.offset >= _controller.position.maxScrollExtent &&
          !_controller.position.outOfRange) {
        ref.read(streamStateProvider.notifier).getNextPageSeriesData();
      }
    });

    final _featuredScrollController = useScrollController();
    _featuredScrollController.addListener(() {
      // reached End of scroll
      if (_featuredScrollController.offset >=
              _featuredScrollController.position.maxScrollExtent &&
          !_featuredScrollController.position.outOfRange) {
        ref.read(streamStateProvider.notifier).getUpcomingNextData();
      }
    });

    return SafeArea(
      child: NestedScrollView(
        headerSliverBuilder: (context, isexpanded) {
          return const [
            HomeAppBar(
              title: 'Live Streams',
            )
          ];
        },
        body: RefreshIndicator(
          color: Theme.of(context).colorScheme.secondary,
          onRefresh: () {
            final futures = [
              ref.read(streamStateProvider.notifier).getSeriesData(),
              ref.read(streamStateProvider.notifier).getFeaturedData(),
              ref.read(streamStateProvider.notifier).getUpcomingData(),
            ];

            return Future.wait(futures);
          },
          child: clubsProvider.when(
            loading: () => Container(),
            error: (e, s) => Container(),
            data: (streams) {
              return CustomScrollView(
                controller: _featuredScrollController,
                slivers: [
                  if (streams.liveClubs.isNotEmpty)
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 300,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CarouselSlider(
                              options: CarouselOptions(
                                height: 280.0,
                                enlargeCenterPage: true,
                                enableInfiniteScroll: false,
                              ),
                              items: streams.liveClubs.map((c) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    if (c.conversation?.recordingDetails !=
                                        null) {
                                      return PastLiveGridTile(c);
                                    }
                                    return LiveGridTile(c);
                                  },
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (streams.series.isNotEmpty)
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 80,
                        child: UpcomingGridTitleTile(
                          UpcomingGridItem(
                            title: 'Series by our creators',
                            color: '#B02A2A',
                            type: GridItemType.title,
                            icon: Icon(
                              Icons.schedule,
                              size: 80,
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (streams.series.isNotEmpty)
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 250,
                        child: ListView.separated(
                          controller: _controller,
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 20),
                          scrollDirection: Axis.horizontal,
                          itemCount: streams.series.length,
                          padding: const EdgeInsets.only(left: 20, right: 80),
                          itemBuilder: (BuildContext context, int index) =>
                              SizedBox(
                            width: 150,
                            child: SeriesGridTile(
                              streams.series[index],
                            ),
                          ),
                        ),
                      ),
                    ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 80,
                      child: UpcomingGridTitleTile(
                        UpcomingGridItem(
                          title: 'Going Live Soon',
                          color: '#B02A2A',
                          type: GridItemType.title,
                          icon: Icon(
                            Icons.schedule,
                            size: 80,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if (streams.upcomingClubs[index].type ==
                            GridItemType.loader) {
                          return SizedBox(
                            height: 100,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          );
                        }
                        return SizedBox(
                          height: 300,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: UpcomingGridTile(
                              streams.upcomingClubs[index],
                            ),
                          ),
                        );
                      },
                      childCount: streams.upcomingClubs.length,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class SimilarStream extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Text('TODO HERE SIMILAR STREAMS');
    // return clubsProvider.when(
    //     loading: () => Container(),
    //     error: (e, s) => Container(),
    //     data: (streams) {
    //       return StaggeredGrid.count(
    //         padding: const EdgeInsets.all(8),
    //         crossAxisCount: 2,
    //         itemCount: streams.series.length,
    //         itemBuilder: (BuildContext context, int index) {
    //           return Padding(
    //               padding: const EdgeInsets.symmetric(horizontal: 20.0),
    //               child: UpcomingGridTile(streams.series[index]));
    //         },
    //         staggeredTileBuilder: (int index) {
    //           return const StaggeredTile.count(2, 1.5);
    //         },
    //         mainAxisSpacing: 40.0,
    //         crossAxisSpacing: 40.0,
    //       );
    //     });
  }
}
