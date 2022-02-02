import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/features/club/presentation/screens/streams/past_stream_screen_state.dart';
import 'package:worknetwork/features/club/presentation/screens/streams/stream_screen.dart';
import 'package:worknetwork/features/club/presentation/widgets/home_app_bar.dart';

class PastStreamTab extends HookWidget {

  @override
  Widget build(BuildContext context) {
    final pastStreamProvider = useProvider(pastStreamsStateProvider);

    return SafeArea(
      child: NestedScrollView(
        headerSliverBuilder: (context, isexpanded) {
          return const [
            HomeAppBar(
              title: 'Past Streams',
            )
          ];
        },
        body: RefreshIndicator(
          color: Theme.of(context).accentColor,
          onRefresh: () {
            final futures = [
              context.read(pastStreamsStateProvider.notifier).getPastData(),
            ];

            return Future.wait(futures);
          },
          child: pastStreamProvider.when(
              loading: () => Container(),
              error: (e, s) => Container(),
              data: (streams) {
                return StaggeredGridView.countBuilder(
                  padding: const EdgeInsets.all(8),
                  crossAxisCount: 2,
                  itemCount: streams.pastClubs.length,
                  itemBuilder: (BuildContext context, int index) {
                    
                    final upIndex = index;
                    switch (streams.pastClubs[upIndex].type) {
                      case GridItemType.title:
                        return UpcomingGridTitleTile(
                            streams.pastClubs[upIndex]);
                      default:
                        return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: UpcomingGridTile(
                                streams.pastClubs[upIndex]));
                    }
                  },
                  staggeredTileBuilder: (int index) {
                    final upIndex = index;
                    switch (streams.pastClubs[upIndex].type) {
                      case GridItemType.upcoming:
                        return const StaggeredTile.count(2, 1.5);
                      case GridItemType.title:
                        return const StaggeredTile.count(2, 0.3);
                      default:
                        return const StaggeredTile.count(2, 1.5);
                    }
                  },
                  mainAxisSpacing: 40.0,
                  crossAxisSpacing: 40.0,
                );
              }),
        ),
      ),
    );
  }
}