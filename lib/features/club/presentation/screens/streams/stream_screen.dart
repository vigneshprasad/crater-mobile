import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide ReadContext;
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:worknetwork/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:worknetwork/features/club/presentation/screens/streams/stream_screen_state.dart';
import 'package:worknetwork/features/club/presentation/screens/streams/webinar_screen.dart';
import 'package:worknetwork/features/club/presentation/widgets/home_app_bar.dart';
import 'package:worknetwork/features/conversations/domain/entity/webinar_entity/webinar_entity.dart';
import 'package:worknetwork/features/meeting/presentation/screens/dyte_meeting_screen.dart';
import 'package:worknetwork/routes.gr.dart';

class StreamTab extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final clubsProvider = useProvider(streamStateProvider);

    final _controller = useScrollController();
    _controller.addListener(() {
      // reached End of scroll
      if (_controller.offset >= _controller.position.maxScrollExtent &&
          !_controller.position.outOfRange) {
        context.read(streamStateProvider.notifier).getNextPageSeriesData();
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
            color: Theme.of(context).accentColor,
            onRefresh: () {
              final futures = [
                context.read(streamStateProvider.notifier).getLiveData(),
                context.read(streamStateProvider.notifier).getSeriesData(),
                context.read(streamStateProvider.notifier).getFeaturedData(),
                context.read(streamStateProvider.notifier).getUpcomingData(),
              ];

              return Future.wait(futures);
            },
            child: clubsProvider.when(
                loading: () => Container(),
                error: (e, s) => Container(),
                data: (streams) {
                  return CustomScrollView(
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
                                          return LiveGridTile(c);
                                        },
                                      );
                                    }).toList(),
                                  ),
                                ],
                              )),
                        ),
                      if (streams.series.isNotEmpty)
                        SliverToBoxAdapter(
                          child: SizedBox(
                            height: 80,
                            child: UpcomingGridTitleTile(
                              UpcomingGridItem(
                                  title: 'Series by our creators',
                                  color: '#B02A2A',
                                  type: GridItemType.title,
                                  icon: const Icon(
                                    Icons.schedule,
                                    size: 80,
                                  )),
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
                              padding:
                                  const EdgeInsets.only(left: 20, right: 80),
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
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: 80,
                          child: UpcomingGridTitleTile(
                            UpcomingGridItem(
                                title: 'Going Live Soon',
                                color: '#B02A2A',
                                type: GridItemType.title,
                                icon: const Icon(
                                  Icons.schedule,
                                  size: 80,
                                )),
                          ),
                        ),
                      ),
                      SliverList(
                          delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return SizedBox(
                              height: 300,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: UpcomingGridTile(
                                  streams.upcomingClubs[index],
                                ),
                              ));
                        },
                        childCount: streams.upcomingClubs.length,
                      )),
                    ],
                  );
                })),
      ),
    );
  }
}

class SimilarStream extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final clubsProvider = useProvider(streamStateProvider);

    return clubsProvider.when(
        loading: () => Container(),
        error: (e, s) => Container(),
        data: (streams) {
          return StaggeredGridView.countBuilder(
            padding: const EdgeInsets.all(8),
            crossAxisCount: 2,
            itemCount: streams.series.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: UpcomingGridTile(streams.series[index]));
            },
            staggeredTileBuilder: (int index) {
              return const StaggeredTile.count(2, 1.5);
            },
            mainAxisSpacing: 40.0,
            crossAxisSpacing: 40.0,
          );
        });
  }
}

class UpcomingGridTitleTile extends StatelessWidget {
  final UpcomingGridItem item;
  const UpcomingGridTitleTile(
    this.item, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Wrap(
          spacing: 8,
          children: item.title == 'Going Live Soon'
              ? [
                  Text('Going', style: Theme.of(context).textTheme.headline6),
                  Text('live',
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          ?.copyWith(color: Theme.of(context).accentColor)),
                  Text('soon', style: Theme.of(context).textTheme.headline6),
                ]
              : [
                  Text('Series',
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          ?.copyWith(color: Theme.of(context).accentColor)),
                  Text('by our creators',
                      style: Theme.of(context).textTheme.headline6),
                ],
        ),
      ),
    );
  }
}

enum GridItemType {
  title,
  live,
  upcoming,
  featured,
  past,
  loader,
  series,
}

class UpcomingGridItem {
  final Webinar? conversation;
  final String? title;
  final Icon? icon;
  final String? color;
  final GridItemType type;

  UpcomingGridItem({
    this.conversation,
    this.title,
    this.icon,
    this.color,
    required this.type,
  });
}

class UpcomingGridTile extends StatelessWidget {
  final UpcomingGridItem item;
  const UpcomingGridTile(
    this.item, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final conversation = item.conversation!;
    final user = conversation.hostDetail;
    final topic = conversation.topicDetail;
    final tag = topic?.root;
    String description = user?.introduction ?? topic?.name ?? ' ';
    if (description.isEmpty) {
      description = item.conversation?.description ?? '';
    }
    String title = user?.name ?? '';

    if (item.type == GridItemType.upcoming || item.type == GridItemType.past) {
      title = topic?.name ?? '';
      description = user?.name ?? '';
    }

    return InkWell(
      onTap: () {
        if (item.type == GridItemType.upcoming) {
          AutoRouter.of(context)
              .push(ConversationScreenRoute(id: conversation.id));

          // final link = 'https://crater.club/session/${conversation.id}';

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
        } else if (item.type == GridItemType.past) {
          AutoRouter.of(context)
              .push(PastStreamScreenRoute(id: conversation.id));
        }
      },
      borderRadius: BorderRadius.circular(12),
      child: GridTile(
          child: Column(
        children: [
          Expanded(
              child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
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
                  if (item.type == GridItemType.upcoming)
                    LiveTime(date: item.conversation?.start?.toLocal()),
                  if (item.type == GridItemType.past)
                    const Center(
                      child: Icon(Icons.play_circle, size: 80),
                    )
                ],
              ),
            ),
          )),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(user?.photo ?? ''),
                    backgroundColor: Theme.of(context).dialogBackgroundColor,
                    radius: 28,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              style: Theme.of(context).textTheme.subtitle2,
                              maxLines: 2,
                            ),
                          ),
                          const SizedBox(width: 8),
                          if (tag?.name?.isNotEmpty ?? false)
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border:
                                    Border.all(color: Colors.white, width: 0.5),
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
      )),
    );
  }
}

class SeriesGridTile extends StatelessWidget {
  final UpcomingGridItem item;
  const SeriesGridTile(
    this.item, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final conversation = item.conversation!;
    final user = conversation.hostDetail;
    final topic = conversation.topicDetail;
    String description = user?.introduction ?? topic?.name ?? ' ';
    if (description.isEmpty) {
      description = item.conversation?.description ?? '';
    }
    final title = user?.name ?? '';

    return InkWell(
      onTap: () {
          AutoRouter.of(context)
              .push(ConversationScreenRoute(id: conversation.id));
      },
      borderRadius: BorderRadius.circular(12),
      child: GridTile(
          child: Column(
        children: [
          Expanded(
              child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
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
                  if (item.type == GridItemType.upcoming)
                    LiveTime(date: item.conversation?.start?.toLocal()),
                  if (item.type == GridItemType.past)
                    const Center(
                      child: Icon(Icons.play_circle, size: 80),
                    )
                ],
              ),
            ),
          )),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              style: Theme.of(context).textTheme.subtitle2,
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}

class LiveTime extends StatelessWidget {
  const LiveTime({
    Key? key,
    this.date,
  }) : super(key: key);

  final DateTime? date;

  @override
  Widget build(BuildContext context) {
    final format = DateFormat('d MMM @ H:mm');
    var dateString = '';
    if (date != null) {
      dateString = format.format(date!);
    }
    return Positioned(
      left: 10,
      top: 10,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: BorderRadius.circular(4)),
        child: Row(
          children: [
            Text(
              'Live On',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(color: Theme.of(context).accentColor),
            ),
            const SizedBox(width: 8),
            Text(
              dateString,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class LiveGridTile extends StatelessWidget {
  final UpcomingGridItem item;
  const LiveGridTile(
    this.item, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      onTap: () {
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
          final user = BlocProvider.of<AuthBloc>(context).state.user;
          if (user == null) {
            // Show login
            AutoRouter.of(context).push(const WelcomeScreenRoute());
            return;
          }

          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  DyteMeetingScreen(meetingId: conversation.id!)));
        } else {
          AutoRouter.of(context)
              .push(ConversationScreenRoute(id: conversation.id));
        }
      },
      borderRadius: BorderRadius.circular(12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
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
                              horizontal: 4, vertical: 2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.red,
                          ),
                          child: const Text('LIVE'),
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
                                  style: Theme.of(context).textTheme.subtitle2,
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
                                        color: Colors.white, width: 0.5),
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
        )),
      ),
    );
  }
}
