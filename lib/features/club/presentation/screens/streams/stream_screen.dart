import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neopop/widgets/buttons/neopop_tilted_button/neopop_tilted_button.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:worknetwork/constants/app_constants.dart';
import 'package:worknetwork/core/color/color.dart';
import 'package:worknetwork/features/auth/presentation/screens/splash/splash_screen_state.dart';
import 'package:worknetwork/features/club/domain/entity/upcoming_grid_item.dart';
import 'package:worknetwork/features/club/presentation/screens/streams/past_stream_screen_state.dart';
import 'package:worknetwork/features/club/presentation/screens/streams/stream_screen_state.dart';
import 'package:worknetwork/features/club/presentation/widgets/home_app_bar.dart';
import 'package:worknetwork/features/club/presentation/widgets/past_live_grid_tile.dart';
import 'package:worknetwork/features/connection/data/models/creator_response.dart';
import 'package:worknetwork/features/connection/presentation/widget/featured_list/creator_follow_card.dart';
import 'package:worknetwork/features/connection/presentation/widget/featured_list/creator_list_state.dart';
import 'package:worknetwork/features/conversations/presentation/widgets/plain_button.dart';
import 'package:worknetwork/features/conversations/presentation/widgets/stream_time.dart';
import 'package:worknetwork/features/meeting/presentation/screens/dyte_meeting_screen.dart';
import 'package:worknetwork/routes.gr.dart';

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
              title: 'Discover Streams',
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
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        bottom: 16,
                      ),
                      child: Text(
                        'Watch streams, chat with creators and place bids',
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            ?.copyWith(fontSize: 14),
                      ),
                    ),
                  ),
                  if (streams.liveClubs.isNotEmpty)
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 360,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CarouselSlider(
                              options: CarouselOptions(
                                height: 340.0,
                                enlargeCenterPage: true,
                                enableInfiniteScroll: false,
                              ),
                              items: streams.liveClubs.map((c) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    // if (c.conversation?.recordingDetails !=
                                    //     null) {
                                    //   return PastLiveGridTile(c);
                                    // }
                                    return PastLiveGridTile(c);
                                  },
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 180,
                      child: _TopCreatorList(
                        creators: streams.topCreators,
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                      child: _CategoryWindowView(
                    type: GridItemType.upcoming,
                  )),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 610,
                      child: _GoingLiveList(
                        gridItems: streams.upcomingClubs.take(3).toList(),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 610,
                      child: _PastStreamList(
                        gridItems: streams.pastClubs.take(3).toList(),
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 232,
                      child: _YourJourney(),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: SvgPicture.asset(
                        AppSvgAssets.homeFooter,
                        fit: BoxFit.contain,
                        height: 180,
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _YourJourney extends StatelessWidget {
  const _YourJourney({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your journey',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 16,
                  right: 16,
                  bottom: 16,
                ),
                height: 200,
                color: Colors.white,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Become a Creator',
                        style: Theme.of(context).textTheme.headline6?.copyWith(
                              color: Theme.of(context).backgroundColor,
                            ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        'stream, get discovered and launch auctions on Crater for your community',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            ?.copyWith(color: HexColor.fromHex('#959595')),
                      ),
                      const SizedBox(
                        height: 28,
                      ),
                      Expanded(
                        child: NeoPopTiltedButton(
                          key: const Key("goliveaudience"),
                          color: Theme.of(context).primaryColor,
                          onTapUp: () {
                            launchUrlString(
                              'https://calendly.com/craterclub/?utm_source=creator_hub&utm_medium=website&utm_campaign=creator',
                              mode: LaunchMode.inAppWebView,
                            );
                          },
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 15,
                              ),
                              child: Text(
                                'Start your journey',
                                style: Theme.of(context).textTheme.button,
                              ),
                            ),
                          ),
                        ),
                      )
                    ]),
              ),
            ],
          ),
        ),
        Positioned(
          top: 34,
          right: 8,
          child: SvgPicture.asset(AppSvgAssets.journeyStars),
        ),
      ],
    );
  }
}

class _GoingLiveList extends HookConsumerWidget {
  final List<UpcomingGridItem> gridItems;
  const _GoingLiveList({
    required this.gridItems,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Text(
              'Goint live soon',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const SizedBox(
            height: 12,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                maxLines: 2,
                                style: Theme.of(context).textTheme.bodyText2,
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
                                    style: Theme.of(context).textTheme.caption,
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
            if (index == gridItems.length - 1)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Divider(),
                    PlainButton(
                      title: 'View All',
                      icon: Icons.arrow_forward_ios,
                      borderColor: HexColor.fromHex('#373737'),
                      onPressed: () {
                        AutoRouter.of(context)
                            .push(UpcomingStreamScreenRoute());
                      },
                    ),
                  ],
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
  }
}

class _PastStreamList extends HookConsumerWidget {
  final List<UpcomingGridItem> gridItems;
  const _PastStreamList({
    required this.gridItems,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            height: 36,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Past streams',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          const CategoryGridView(type: GridItemType.past),
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
                  PastStreamDetailScreenRoute(id: c.conversation?.id),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                maxLines: 2,
                                style: Theme.of(context).textTheme.bodyText2,
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
                                    style: Theme.of(context).textTheme.caption,
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
                    StreamTime(start: c.conversation?.start)
                  ],
                ),
              ),
            ),
            if (index == gridItems.length - 1)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Divider(),
                    PlainButton(
                      title: 'View All',
                      icon: Icons.arrow_forward_ios,
                      borderColor: HexColor.fromHex('#373737'),
                      onPressed: () {
                        AutoRouter.of(context).push(PastStreamScreenRoute());
                      },
                    ),
                  ],
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
  }
}

class _TopCreatorList extends HookConsumerWidget {
  final List<CreatorRow> creators;

  const _TopCreatorList({required this.creators});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(authStateProvider.notifier).getUser();
    final _controller = useScrollController();
    _controller.addListener(() {
      // reached End of scroll
      if (_controller.offset >= _controller.position.maxScrollExtent &&
          !_controller.position.outOfRange) {
        ref.read(creatorStateProvider('').notifier).getNextPageProfileList('');
      }
    });

    return creators.isEmpty
        ? Container()
        : Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                child: Text(
                  'Top Creators',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              SizedBox(
                height: 250,
                width: MediaQuery.of(context).size.width,
                child: ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 20,
                  ),
                  controller: _controller,
                  itemCount: creators.length,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.fromLTRB(20, 8, 8, 40),
                  itemBuilder: (context, index) => CreatorFollowCard(
                    item: creators[index],
                    authUserPk: user?.pk,
                  ),
                ),
              ),
            ],
          );
  }
}

class _CategoryWindowView extends HookConsumerWidget {
  final GridItemType type;

  const _CategoryWindowView({required this.type});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final webinarCategoryProvider = ref.watch(webinarCategoryStateProvider);
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Container(
            color: HexColor.fromHex('#882EE8').withOpacity(0.16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Top categories',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 221,
                  child: webinarCategoryProvider.when(
                    loading: () => Container(),
                    data: (categoryList) {
                      return ListView.separated(
                        itemCount: categoryList.length,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 12),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              if (type == GridItemType.past) {
                                AutoRouter.of(context).navigate(
                                  PastStreamScreenRoute(
                                    categoryId: categoryList[index].pk ?? 0,
                                    categoryName: categoryList[index].name,
                                  ),
                                );
                              } else if (type == GridItemType.upcoming) {
                                AutoRouter.of(context).navigate(
                                  UpcomingStreamScreenRoute(
                                    categoryId: categoryList[index].pk ?? 0,
                                    categoryName: categoryList[index].name,
                                  ),
                                );
                              }
                            },
                            child: GridTile(
                              child: Stack(
                                children: [
                                  SvgPicture.asset(AppSvgAssets.categoryWindow),
                                  Container(
                                    width: 152,
                                    height: 220,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                    alignment: Alignment.center,
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 40,
                                        ),
                                        Image.asset(
                                          AppImageAssets.design.assetName,
                                          height: 74,
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          categoryList[index].name ?? '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    child: PlainButton(
                                      title: 'Explore',
                                      bgColor: HexColor.fromHex('#FFBF20'),
                                      textColor:
                                          Theme.of(context).backgroundColor,
                                      icon: Icons.arrow_forward,
                                      onPressed: () {},
                                    ),
                                    top: 180,
                                    left: 0,
                                    right: 0,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    error: (e, s) => Container(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 36,
                  color: HexColor.fromHex('#5F1DAB').withOpacity(0.24),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Image.asset(AppImageAssets.categoryFooter.assetName),
                      Spacer(),
                      Text('More categories coming soon!')
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: SvgPicture.asset(AppSvgAssets.categoryStar),
        ),
      ],
    );
  }
}
