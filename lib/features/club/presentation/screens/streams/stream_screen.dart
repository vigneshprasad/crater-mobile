import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';
import 'package:worknetwork/features/club/presentation/screens/streams/stream_screen_state.dart';
import 'package:worknetwork/features/club/presentation/widgets/home_app_bar.dart';
import 'package:worknetwork/features/conversations/domain/entity/webinar_entity/webinar_entity.dart';
import 'package:worknetwork/features/meeting/presentation/screens/dyte_meeting_screen.dart';
import 'package:worknetwork/routes.gr.dart';
import 'package:worknetwork/utils/navigation_helpers/navigate_post_auth.dart';

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

    final _featuredScrollController = useScrollController();
    _featuredScrollController.addListener(() {
      // reached End of scroll
      if (_featuredScrollController.offset >=
              _featuredScrollController.position.maxScrollExtent &&
          !_featuredScrollController.position.outOfRange) {
        context.read(streamStateProvider.notifier).getUpcomingNextData();
      }
    });

    // final isMounted = useIsMounted();
    // final timer = Timer.periodic(const Duration(seconds: 120), (timer) {
    //   if (isMounted()) {
    //     context.read(streamStateProvider.notifier).getFeaturedData();
    //   }
    // });

    // useEffect(() {
    //   return () {
    //     timer.cancel();
    //   };
    // }, []);

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
                                          if (c.conversation
                                                  ?.recordingDetails !=
                                              null) {
                                            return PastLiveGridTile(c);
                                          }
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
                          if (streams.upcomingClubs[index].type ==
                              GridItemType.loader) {
                            return SizedBox(
                              height: 100,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: Theme.of(context).accentColor,
                                ),
                              ),
                            );
                          }
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

class UpcomingGridItem extends Equatable {
  final Webinar? conversation;
  final String? title;
  final Icon? icon;
  final String? color;
  final GridItemType type;
  final bool? rsvped;

  UpcomingGridItem({
    this.conversation,
    this.title,
    this.icon,
    this.color,
    required this.type,
    this.rsvped,
  });

  @override
  List<Object?> get props => [conversation?.id];
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
              .push(PastStreamDetailScreenRoute(id: conversation.id));
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
        AutoRouter.of(context).push(SeriesScreenRoute(id: conversation.id));
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
      onTap: () async {
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
          final loginStatus = await manageLoginPopup(context);
          if (loginStatus == false) {
            return;
          }

          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DyteMeetingScreen(
                    meetingId: conversation.id!,
                    creatorId: conversation.hostDetail?.creatorDetail?.id ?? 0,
                  )));
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

class PastLiveGridTile extends StatelessWidget {
  final UpcomingGridItem item;
  const PastLiveGridTile(
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
      onTap: () async {
        AutoRouter.of(context)
            .push(PastStreamDetailScreenRoute(id: conversation.id));
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
                      const Center(
                          child: Icon(
                        Icons.play_circle,
                        size: 60,
                      )),
                      // WebinarVideoPlayer(
                      //     key: Key(item.conversation!.id.toString()),
                      //     conversation: item.conversation!),
                      if (item.type == GridItemType.featured)
                        LiveTime(date: item.conversation?.start?.toLocal()),
                      if (item.type == GridItemType.past)
                        Container(
                          margin: const EdgeInsets.only(top: 8, left: 12),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Theme.of(context).accentColor,
                          ),
                          child: const Text('Previously LIVE'),
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
                            maxLines: 1,
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

class WebinarVideoPlayer extends StatefulWidget {
  const WebinarVideoPlayer({
    Key? key,
    required this.conversation,
  }) : super(key: key);

  final Webinar conversation;

  @override
  _WebinarVideoPlayerState createState() => _WebinarVideoPlayerState();
}

class _WebinarVideoPlayerState extends State<WebinarVideoPlayer> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    _controller = VideoPlayerController.network(
        widget.conversation.recordingDetails?.recording ?? '');

    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.initialize().then((_) {
      _controller.setVolume(0.0);
      _controller.seekTo(const Duration(minutes: 10));
      return setState(() {});
    });
    _controller.play();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).dialogBackgroundColor,
        width: double.infinity,
        child: Stack(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    widget.conversation.topicDetail?.image ?? '',
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                VideoPlayer(_controller),
                // _ControlsOverlay(
                //   isPlaying: _controller.value.isPlaying,
                //   isFullScreen: widget.isFullScreen,
                // ),
                // VideoProgressIndicator(
                //   _controller,
                //   colors: VideoProgressColors(playedColor: Theme.of(context).accentColor),
                //   allowScrubbing: true,
                //   padding: EdgeInsets.only(
                //     bottom: 0,
                //     top: 20,
                //   ),
                // ),
              ],
            ),
          ],
        ));
  }
}
