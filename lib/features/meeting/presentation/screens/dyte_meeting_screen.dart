import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dyte_client/dyte.dart';
import 'package:dyte_client/dyteMeeting.dart';
import 'package:dyte_client/dyteSelfParticipant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/constants/app_constants.dart';
import 'package:worknetwork/core/analytics/analytics.dart';
import 'package:worknetwork/core/analytics/anlytics_events.dart';
import 'package:worknetwork/core/color/color.dart';
import 'package:worknetwork/core/features/socket_io/socket_io_manager.dart';
import 'package:worknetwork/core/widgets/base/base_network_image/base_network_image.dart';
import 'package:worknetwork/core/widgets/root_app.dart';
import 'package:worknetwork/features/auth/presentation/screens/splash/splash_screen_state.dart';
import 'package:worknetwork/features/chat/presentation/screens/chat_screen.dart';
import 'package:worknetwork/features/club/domain/entity/upcoming_grid_item.dart';
import 'package:worknetwork/features/club/presentation/screens/streams/past_stream_screen_state.dart';
import 'package:worknetwork/features/connection/data/models/creator_response.dart';
import 'package:worknetwork/features/connection/presentation/widget/featured_list/creator_list_state.dart';
import 'package:worknetwork/features/conversations/domain/entity/conversation_entity/conversation_entity.dart';
import 'package:worknetwork/features/conversations/domain/entity/webinar_entity/webinar_entity.dart';
import 'package:worknetwork/features/conversations/presentation/widgets/plain_button.dart';
import 'package:worknetwork/features/meeting/presentation/screens/dyte_meeting_screen_state.dart';
import 'package:worknetwork/features/profile/presentation/screens/profile_screen/profile_streams_state.dart';
import 'package:worknetwork/routes.gr.dart';

class DyteMeetingScreen extends HookConsumerWidget {
  final Webinar conversation;

  DyteMeetingScreen({
    Key? key,
    required this.conversation,
  }) : super(key: key);

  late Size size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    size = MediaQuery.of(context).size;

    final meetingId = conversation.id ?? 0;
    // final creator = conversation.hostDetail?.creatorDetail ?? Creator();

    final profileState = ref.watch(getDyteCredsNotifierProvider(meetingId));

    final meetingHandler = useState<DyteMeetingHandler?>(null);
    final participant = useState<DyteSelfParticipant?>(null);

    final isExpanded = useState(true);
    final isFullscreen = useState(false);

    final videoHeight = min(size.width, size.height);
    final videoWidth = MediaQuery.of(context).size.width;

    final statusBarHeight = MediaQuery.of(context).viewPadding.top;
    final chatHeight =
        MediaQuery.of(context).size.height - videoHeight - statusBarHeight;

    final socketIOManager = ref.read(userPermissionNotifierProvider.notifier);

    final isOngoingMeeting = useState(false);

    final config = useState<Map<String, dynamic>>({
      'header': false,
      'controlBar': false,
      'controlBarElements': {
        'plugins': false,
        'participants': false,
        'chat': false,
        'polls': false,
      },
      'dimensions': {
        'height': videoHeight,
        'width': videoWidth,
        // 'mode': 'fillParent',
      },
      'colors': {
        'primary': '#9146FF',
        'secondary': '#010101',
        'textPrimary': '#FFFFFF',
        'videoBackground': '#010101'
      },
    });

    Future<void> toggleChat() async {
      isFullscreen.value = !isFullscreen.value;

      final videoWidth = size.height;
      meetingHandler.value?.updateUIConfig({
        'dimensions': {
          'height': videoHeight,
          'width': videoWidth,
          // 'mode': 'fillParent',
        }
      });

      await SystemChrome.setPreferredOrientations([
        if (isFullscreen.value == true)
          DeviceOrientation.landscapeLeft
        else
          DeviceOrientation.portraitUp,
      ]);
    }

    final authUserPK = ref.read(authStateProvider.notifier).getUser()?.pk;
    final article = conversation.topicDetail?.articleDetail;

    final heading =
        article != null ? article.description : conversation.topicDetail?.name;
    final shareText = Uri.encodeQueryComponent(heading ?? '');

    Future<bool> endCall() async {
      isOngoingMeeting.value = false;

      meetingHandler.value?.events.clear();
      meetingHandler.value?.events.removeAllByEvent('meetingJoin');
      meetingHandler.value?.events.removeAllByEvent('meetingDisconnected');
      meetingHandler.value?.events.removeAllByEvent('meetingEnd');

      participant.value?.leaveRoom();

      meetingHandler.dispose();

      socketIOManager.onLeaveStream();

      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);

      return true;
    }

    return WillPopScope(
      onWillPop: () async => endCall(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              onPressed: () {
                final url =
                    'https://crater.club/session/${conversation.id}?utm_source=in_app_share&referrer_id=$authUserPK&utm_campaign=mobile_app';
                shareApp(context, url, shareText);
              },
              icon: const Icon(Icons.share_outlined),
            ),
          ],
        ),
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: profileState.when(
          data: (state) => Padding(
            padding: EdgeInsets.only(top: statusBarHeight),
            child: Stack(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: videoHeight,
                      width: videoWidth,
                      child: DyteMeeting(
                        roomName: state.room,
                        authToken: state.token,
                        uiConfig: config.value,
                        onInit: (DyteMeetingHandler handler) async {
                          meetingHandler.value = handler;

                          handler.events.on('meetingJoin', context, (ev, c) {
                            isOngoingMeeting.value = true;
                            Future.delayed(
                              const Duration(milliseconds: 500),
                            ).then((value) {
                              final analytics = ref.read(analyticsProvider);
                              analytics.trackEvent(
                                eventName: AnalyticsEvents.joinStream,
                                properties: {
                                  "id": meetingId,
                                },
                              );
                            });

                            socketIOManager.onJoinStream(meetingId);
                          });

                          handler.events.on('meetingEnd', context, (ev, c) {
                            isOngoingMeeting.value = false;
                            AutoRouter.of(context).pop();
                          });

                          handler.events.on('meetingDisconnected', this,
                              (ev, cont) {
                            isOngoingMeeting.value = false;
                            AutoRouter.of(context).pop();
                          });

                          participant.value = await meetingHandler.value?.self;
                        },
                      ),
                    ),
                    SizedBox(
                      height: videoHeight,
                      width: videoWidth,
                      child: SafeArea(
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: IconButton(
                                onPressed: () {
                                  AutoRouter.of(context).pop();
                                },
                                icon: const Icon(Icons.call_end),
                                iconSize: 32,
                                color: HexColor.fromHex('#FA5B5B'),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: IconButton(
                                onPressed: toggleChat,
                                icon: Icon(
                                  isFullscreen.value
                                      ? Icons.fullscreen_exit
                                      : Icons.fullscreen,
                                  color: Colors.white70,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Expanded(child: SizedBox()),
                    Container(
                      color: Theme.of(context).backgroundColor,
                      height: isFullscreen.value ? 0 : chatHeight,
                      width: videoWidth,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: _SimilarStreamList(
                        conversation: state.webinar,
                        userId: "",
                      ),
                    ),
                  ],
                ),
                if (!isFullscreen.value)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      children: [
                        const Expanded(child: SizedBox()),
                        const Divider(
                          height: 1,
                          color: Colors.white,
                        ),
                        Container(
                          color: Theme.of(context).backgroundColor,
                          child: SafeArea(
                            top: false,
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(
                                    left: 16,
                                  ),
                                  height: 44,
                                  child: Row(
                                    children: [
                                      Text(
                                        'LIVE CHAT',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                      const Spacer(),
                                      IconButton(
                                        icon: SvgPicture.asset(
                                          isExpanded.value
                                              ? AppSvgAssets.collapse
                                              : AppSvgAssets.expand,
                                          width: 18,
                                        ),
                                        onPressed: () {
                                          isExpanded.value = !isExpanded.value;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  height: isExpanded.value
                                      ? (chatHeight - 45 < 0
                                          ? 0
                                          : chatHeight - 45)
                                      : 0,
                                  width: videoWidth,
                                  child: Column(
                                    children: [
                                      // const Divider(
                                      //   height: 1,
                                      // ),
                                      // SizedBox(
                                      //   height: 52,
                                      //   width: double.infinity,
                                      //   child: Row(
                                      //     mainAxisAlignment:
                                      //         MainAxisAlignment.spaceEvenly,
                                      //     children: [
                                      //       TextButton(
                                      //         onPressed: () {},
                                      //         child: Row(
                                      //           children: [
                                      //             SvgPicture.asset(
                                      //               AppSvgAssets.chat,
                                      //               width: 18,
                                      //             ),
                                      //             const SizedBox(
                                      //               width: 4,
                                      //             ),
                                      //             Text(
                                      //               'Chat',
                                      //               style: Theme.of(context)
                                      //                   .textTheme
                                      //                   .titleSmall,
                                      //             ),
                                      //           ],
                                      //         ),
                                      //       ),
                                      //       const VerticalDivider(
                                      //         indent: 12,
                                      //         endIndent: 12,
                                      //       ),
                                      //       TextButton(
                                      //         onPressed: () {},
                                      //         child: Row(
                                      //           children: [
                                      //             SvgPicture.asset(
                                      //               AppSvgAssets.auction,
                                      //               width: 18,
                                      //             ),
                                      //             const SizedBox(
                                      //               width: 4,
                                      //             ),
                                      //             Text(
                                      //               'Auction',
                                      //               style: Theme.of(context)
                                      //                   .textTheme
                                      //                   .titleSmall,
                                      //             ),
                                      //           ],
                                      //         ),
                                      //       ),
                                      //     ],
                                      //   ),
                                      // ),
                                      const Divider(
                                        height: 1,
                                      ),
                                      Expanded(
                                        child: ChatScreen(
                                          recieverId: '',
                                          groupId: meetingId.toString(),
                                          allowChat: state.allowChat,
                                          streamCreator: state.webinar
                                                  .hostDetail?.creatorDetail ??
                                              const Creator(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                // Align(
                //   alignment: Alignment.bottomLeft,
                //   child: AnimatedContainer(
                //     duration: const Duration(milliseconds: 300),
                //     height: 100,
                //     width: 100,
                //     child: Image.network(
                //         'https://penitence-pre-prod.vercel.app/_next/image?url=https%3A%2F%2F1worknetwork-pre.s3.amazonaws.com%2Fmedia%2Freactions%2Ficons%2Fthe-simpsons-bart-simpson.gif&w=3840&q=75'),
                //   ),
                // )
              ],
            ),
          ),
          loading: () => Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          error: (error, stackTrace) => Center(
            child: Text(error.toString()),
          ),
        ),
      ),
    );
  }
}

class CategoryGridView extends HookConsumerWidget {
  final GridItemType type;
  final int? selectedId;

  const CategoryGridView({
    required this.type,
    this.selectedId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final webinarCategoryProvider = ref.watch(webinarCategoryStateProvider);
    return SizedBox(
      width: double.infinity,
      height: 32,
      child: webinarCategoryProvider.when(
        loading: () => Container(),
        data: (categoryList) {
          return ListView.separated(
            itemCount: categoryList.length,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => const SizedBox(width: 4),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (context, index) {
              final textColor = categoryList[index].pk == selectedId
                  ? Theme.of(context).backgroundColor
                  : null;
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
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).dividerColor,
                      ),
                      color: categoryList[index].pk == selectedId
                          ? Colors.white
                          : null,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      categoryList[index].name ?? '',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2
                          ?.copyWith(color: textColor),
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

class SpeakerWithIntro extends HookConsumerWidget {
  final ConversationUser user;
  final String authUserPk;
  const SpeakerWithIntro({
    Key? key,
    required this.user,
    required this.authUserPk,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subscribers = useState(user.creatorDetail?.subscriberCount ?? 0);
    final description = '${subscribers.value} Followers';
    final headingStyle = Theme.of(context).textTheme.subtitle2;
    final bodyStyle = Theme.of(context).textTheme.caption;
    final isFollower = useState(user.creatorDetail?.isSubscriber ?? false);
    return InkWell(
      onTap: () {
        AutoRouter.of(context).push(
          ProfileScreenRoute(
            userId: user.pk ?? '',
            allowEdit: authUserPk == user.pk,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BaseNetworkImage(
              imageUrl: user.photo,
              defaultImage: AppImageAssets.defaultAvatar,
              imagebuilder: (context, imageProvider) => CircleAvatar(
                backgroundImage: imageProvider,
                radius: 16,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.name ?? '', style: headingStyle),
                  Text(
                    description,
                    overflow: TextOverflow.ellipsis,
                    style: bodyStyle,
                  )
                ],
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              height: 36,
              child: isFollower.value
                  ? PlainButton(
                      title: 'Following',
                      icon: Icons.check,
                      onPressed: () {},
                    )
                  : PlainButton(
                      title: 'Follow',
                      bgColor: Colors.white,
                      textColor: Theme.of(context).backgroundColor,
                      onPressed: () async {
                        final userPK = user.creatorDetail?.id ?? 0;

                        final response = await ref
                            .read(creatorStateProvider('').notifier)
                            .followCreator(userPK, context);

                        response.fold(
                          (failure) {
                            // isFollowing.value = !isFollowing.value;
                            // message.isFollowing = isFollowing.value;
                            // Fluttertoast.showToast(msg: failure.message.toString());
                          },
                          (request) {
                            isFollower.value = !isFollower.value;
                            // subscribers.value = subscribers.value + 1;

                            final analytics = ref.read(analyticsProvider);
                            analytics.trackEvent(
                              eventName: AnalyticsEvents.followCreator,
                              properties: {},
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SimilarStreamList extends HookConsumerWidget {
  final String userId;
  final Webinar conversation;
  const _SimilarStreamList({
    Key? key,
    required this.userId,
    required this.conversation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final upcomingProvider =
        ref.watch(profileUpcomingStreamsStateProvider(userId));

    final authUserPK = ref.read(authStateProvider.notifier).getUser()?.pk;
    final article = conversation.topicDetail?.articleDetail;

    final heading =
        article != null ? article.description : conversation.topicDetail?.name;

    return upcomingProvider.when(
      loading: () => Container(),
      error: (e, s) => Container(),
      data: (conversations) {
        return ListView.separated(
          itemCount: conversations.length,
          padding: const EdgeInsets.only(bottom: 100),
          itemBuilder: (context, index) {
            final c = conversations[index];
            final image = c.conversation?.topicDetail?.image;
            final title = c.conversation?.topicDetail?.name ?? '';
            final userImage = c.conversation?.hostDetail?.photo;
            final userName = c.conversation?.hostDetail?.name ?? '';

            final items = [
              Text(
                heading ?? '',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              SpeakerWithIntro(
                user: conversation.hostDetail!,
                authUserPk: authUserPK ?? '',
              ),
              const Divider(thickness: 1, height: 16),
              const SizedBox(
                height: 4,
              ),
              Text(
                'Similar Streams',
                style: Theme.of(context).textTheme.titleMedium,
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
                  child: Row(
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
                                    backgroundImage: CachedNetworkImageProvider(
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
                            )
                          ],
                        ),
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
      },
    );
  }
}
