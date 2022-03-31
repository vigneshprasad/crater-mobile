import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/features/club/presentation/screens/streams/stream_screen.dart';

import 'my_past_stream_state.dart';

class MyPastStream extends HookWidget {
  final int? categoryId;
  final String? categoryName;

  const MyPastStream({this.categoryId, this.categoryName});

  @override
  Widget build(BuildContext context) {
    final pastStreamProvider =
        useProvider(myPastStreamsStateProvider(categoryId));

    final _controller = useScrollController();
    _controller.addListener(() {
      // reached End of scroll
      if (_controller.offset >= _controller.position.maxScrollExtent &&
          !_controller.position.outOfRange) {
        context
            .read(myPastStreamsStateProvider(categoryId).notifier)
            .getNextPageConnectableProfileList();
      }
    });

    return pastStreamProvider.when(
        loading: () => Container(),
        error: (e, s) => Container(),
        data: (streams) {
          return ListView.builder(
            itemBuilder: (context, index) {
              switch (streams[index].type) {
                case GridItemType.title:
                  return SizedBox(
                      width: double.infinity,
                      height: 100,
                      child: UpcomingGridTitleTile(streams[index]));
                case GridItemType.loader:
                  return SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: Center(
                        child: CircularProgressIndicator(
                      color: Theme.of(context).accentColor,
                    )),
                  );
                default:
                  return Column(
                    children: [
                      AspectRatio(
                        aspectRatio: 4.0 / 3.0,
                        child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 8),
                            child: UpcomingGridTile(streams[index])),
                      ),
                    ],
                  );
              }
            },
            itemCount: streams.length,
          );
        });
  }
}
