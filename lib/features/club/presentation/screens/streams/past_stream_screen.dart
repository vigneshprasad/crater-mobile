import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/features/club/domain/entity/upcoming_grid_item.dart';
import 'package:worknetwork/features/club/presentation/screens/streams/past_stream_screen_state.dart';
import 'package:worknetwork/features/club/presentation/widgets/home_app_bar.dart';
import 'package:worknetwork/features/club/presentation/widgets/upcoming_grid_tile.dart';
import 'package:worknetwork/features/club/presentation/widgets/upcoming_grid_title_tile.dart';
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
                              CategoryGridView(),
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

class CategoryGridView extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final webinarCategoryProvider = ref.watch(webinarCategoryStateProvider);
    return Container(
      padding: const EdgeInsets.only(bottom: 40),
      width: double.infinity,
      height: 140,
      child: webinarCategoryProvider.when(
        loading: () => Container(),
        data: (categoryList) {
          return GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: categoryList.length,
            scrollDirection: Axis.horizontal,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.27,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  AutoRouter.of(context).navigate(
                    PastStreamScreenRoute(
                      categoryId: categoryList[index].pk ?? 0,
                      categoryName: categoryList[index].name,
                    ),
                  );
                },
                child: GridTile(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      categoryList[index].name ?? '',
                      style: Theme.of(context).textTheme.button,
                    ),
                  ),
                ),
              );
            },
          );
        },
        error: (e, s) => Container(),
      ),
    );
  }
}
