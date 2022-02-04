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

    final _controller = useScrollController();
    _controller.addListener(() {
      // reached End of scroll
      if (_controller.offset >= _controller.position.maxScrollExtent &&
          !_controller.position.outOfRange) {
        context
            .read(pastStreamsStateProvider.notifier)
            .getNextPageConnectableProfileList();
      }
    });

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
                  controller: _controller,
                  padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 80),
                  crossAxisCount: 2,
                  itemCount: streams.length,
                  itemBuilder: (BuildContext context, int index) {
                    final upIndex = index;
                    switch (streams[upIndex].type) {
                      case GridItemType.title:
                        return UpcomingGridTitleTile(streams[upIndex]);
                      case GridItemType.loader:
                        return Center(
                            child: CircularProgressIndicator(
                          color: Theme.of(context).accentColor,
                        ));
                      default:
                        return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: UpcomingGridTile(streams[upIndex]));
                    }
                  },
                  staggeredTileBuilder: (int index) {
                    final upIndex = index;
                    switch (streams[upIndex].type) {
                      case GridItemType.upcoming:
                        return const StaggeredTile.count(2, 1.5);
                      case GridItemType.title:
                        return const StaggeredTile.count(2, 0.3);
                      case GridItemType.loader:
                        return const StaggeredTile.count(2, 0.5);
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
