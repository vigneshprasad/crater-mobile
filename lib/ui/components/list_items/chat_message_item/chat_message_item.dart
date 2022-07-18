import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/constants/work_net_icons_icons.dart';
import 'package:worknetwork/core/analytics/analytics.dart';
import 'package:worknetwork/core/analytics/anlytics_events.dart';
import 'package:worknetwork/core/color/color.dart';
import 'package:worknetwork/core/widgets/root_app.dart';
import 'package:worknetwork/features/auth/domain/entity/user_entity.dart';
import 'package:worknetwork/features/chat/data/models/chat_message_model.dart';
import 'package:worknetwork/features/connection/presentation/widget/featured_list/creator_list_state.dart';
import 'package:worknetwork/ui/base/base_large_button/base_large_button.dart';
import 'package:worknetwork/utils/navigation_helpers/navigate_post_auth.dart';

final chatColors = [
  "#A17BFF",
  "#5BFCAF",
  "#FCBD72",
  "#FF7DAC",
  "#7DCAFF",
  "#ECFF7D",
  "#F96479",
  "#96F464",
  "#F76D52",
  "#71ABFF",
  "#FFCE61",
  "#F7A9E3",
  "#49FC49",
  "#7DFFEC",
  "#F4A8B0",
  "#BDFC97",
];

class ChatMessageItem extends HookConsumerWidget {
  final User? user;
  final ChatMessage message;
  final String conversationId;
  final int creatorId;

  ChatMessageItem({
    Key? key,
    this.user,
    required this.message,
    required this.conversationId,
    required this.creatorId,
  }) : super(key: key);

  late ValueNotifier<bool> isFollowing;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    isFollowing = useState(message.isFollowing ?? false);

    final dateFormat = DateFormat.jm();
    final bool isSender = user?.pk == message.senderId;

    final imageWidth = MediaQuery.of(context).size.width * 0.5;
    const imageHeight = 140.0;
    final timeStampStyle = Theme.of(context)
        .textTheme
        .subtitle2
        ?.copyWith(fontSize: 10, color: Colors.grey);

    final file = message.file;

    final hash = (message.senderDetail?.pk ?? '') +
        (message.senderDetail?.displayName ?? '');
    final colorIndex = hash.hashCode % chatColors.length;
    final nameColor = chatColors[colorIndex];

    Future<void> followHost(BuildContext context) async {
      final userPK = creatorId;

      final response = await ref
          .read(creatorStateProvider('').notifier)
          .followCreator(userPK, context);

      response.fold(
        (failure) {
          isFollowing.value = !isFollowing.value;
          message.isFollowing = isFollowing.value;
          // Fluttertoast.showToast(msg: failure.message.toString());
        },
        (request) {
          isFollowing.value = !isFollowing.value;
          message.isFollowing = isFollowing.value;

          final analytics = ref.read(analyticsProvider);
          analytics.trackEvent(
            eventName: AnalyticsEvents.followCreator,
            properties: {},
          );

          // Fluttertoast.showToast(msg: '');
        },
      );
    }

    Future<void> inviteFriends(BuildContext context) async {
      final url =
          'https://crater.club/session/$conversationId?utm_source=in_app_share&referrer_id=${user?.pk}&utm_campaign=mobile_app';
      shareApp(context, url, '');
    }

    Future<void> exploreStreams(BuildContext context) async {
      await manageRSVPPopup(context, '', slide: 2);
    }

    Future<void> performAction(BuildContext context) async {
      switch (message.action) {
        case 1:
          await followHost(context);
          break;
        case 2:
          await inviteFriends(context);
          break;
        case 3:
          await exploreStreams(context);
          break;
      }
    }

    Widget? buildActionButton(BuildContext context) {
      var actionTitle = 'Okay';
      switch (message.action) {
        case 1:
          actionTitle = isFollowing.value ? 'Following' : 'Follow';
          break;
        case 2:
          actionTitle = 'Invite';
          break;
        case 3:
          actionTitle = 'Explore';
          break;
      }

      return ((message.action == 1 ||
                  message.action == 2 ||
                  message.action == 3) &&
              (message.message?.isNotEmpty ?? false))
          ? Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).backgroundColor,
              ),
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(child: Text(message.message!)),
                  if (isFollowing.value)
                    SizedBox(
                      width: 100,
                      height: 50,
                      child: Center(child: Text(actionTitle)),
                    )
                  else
                    BaseLargeButton(
                      text: actionTitle,
                      onPressed: () => performAction(context),
                    )
                ],
              ),
            )
          : null;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppInsets.sm,
        horizontal: AppInsets.xl,
      ),
      child: Column(
        children: [
          Container(
            alignment: isSender ? Alignment.topRight : Alignment.topLeft,
            // child:
            // Material(
            //   elevation: 1,
            // color: isSender ? AppTheme.blueAccent : Colors.grey[200],
            // borderRadius:
            //     isSender ? senderBorderRadius : recieverBorderRadius,
            child: InkWell(
              onTap: () {},
              splashColor: AppTheme.blueAccent.withOpacity(0.4),
              // borderRadius:
              //     isSender ? senderBorderRadius : recieverBorderRadius,
              child: Container(
                // padding: const EdgeInsets.symmetric(
                //     vertical: AppInsets.l, horizontal: AppInsets.l),
                child: (message.type == 3)
                    ? buildActionButton(context)
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${message.displayName ?? message.senderDetail?.firstName ?? message.senderDetail?.name ?? ''}: ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(
                                      color: HexColor.fromHex(nameColor),
                                    ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              if (message.message?.isNotEmpty ?? false)
                                Expanded(child: Text(message.message!))
                            ],
                          ),
                          if (file != null)
                            CachedNetworkImage(
                              placeholder: (context, url) => Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                width: imageWidth,
                                height: imageHeight,
                                child: Center(
                                  child: LottieBuilder.asset(
                                    "assets/lottie/loading_dots.json",
                                    height: 64,
                                  ),
                                ),
                              ),
                              imageUrl: file,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                width: imageWidth,
                                height: imageHeight,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          if (message.reaction?.file != null)
                            CachedNetworkImage(
                              placeholder: (context, url) => Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                width: 100,
                                height: 100,
                                child: Center(
                                  child: LottieBuilder.asset(
                                    "assets/lottie/loading_dots.json",
                                    height: 64,
                                  ),
                                ),
                              ),
                              imageUrl: message.reaction!.file!,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            )
                        ],
                      ),
              ),
            ),
            // ),
          ),
          if (isSender)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppInsets.sm),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    dateFormat.format(
                      (message.created as Timestamp?)?.toDate() ??
                          DateTime.now(),
                    ),
                    style: timeStampStyle,
                  ),
                  Icon(
                    WorkNetIcons.doublecheck,
                    size: 20,
                    color: message.isRead!
                        ? AppTheme.blueAccent
                        : Colors.grey[400],
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}
