import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:intl/intl.dart';
import 'package:kiwi/kiwi.dart';
import 'package:lottie/lottie.dart';
import 'package:worknetwork/core/analytics/analytics.dart';
import 'package:worknetwork/core/analytics/anlytics_events.dart';
import 'package:worknetwork/core/color/color.dart';
import 'package:worknetwork/core/widgets/root_app.dart';
import 'package:worknetwork/features/connection/presentation/widget/featured_list/creator_list_state.dart';
import 'package:worknetwork/features/conversations/presentation/screens/conversation_screen_2/conversation_screen_state.dart';
import 'package:worknetwork/ui/base/base_large_button/base_large_button.dart';
import 'package:worknetwork/utils/navigation_helpers/navigate_post_auth.dart';

import '../../../../constants/theme.dart';
import '../../../../constants/work_net_icons_icons.dart';
import '../../../../features/auth/domain/entity/user_entity.dart';
import '../../../../features/chat/domain/entity/chat_message_entity.dart';

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

class ChatMessageItem extends StatefulWidget {
  final User user;
  final ChatMessage message;
  final String conversationId;
  final int creatorId;

  ChatMessageItem({
    Key? key,
    required this.user,
    required this.message,
    required this.conversationId,
    required this.creatorId,
  }) : super(key: key);

  @override
  _ChatMessageItemState createState() => _ChatMessageItemState();
}

class _ChatMessageItemState extends State<ChatMessageItem> {
  late bool isFollowing;

  @override
  Widget build(BuildContext context) {
    isFollowing = widget.message.isFollowing ?? false;

    final dateFormat = DateFormat.jm();
    final bool isSender = widget.user.pk == widget.message.senderId;
    const radius = Radius.circular(12.0);
    const senderBorderRadius = BorderRadius.only(
        topLeft: radius, topRight: radius, bottomLeft: radius);
    const recieverBorderRadius = BorderRadius.only(
        topLeft: radius, topRight: radius, bottomRight: radius);
    // final testStyle = Theme.of(context).textTheme.bodyText1?.copyWith(
    //       fontSize: 14,
    //       color: isSender ? Colors.white : Colors.grey[800],
    //     );

    final imageWidth = MediaQuery.of(context).size.width * 0.5;
    const imageHeight = 140.0;
    final timeStampStyle = Theme.of(context)
        .textTheme
        .subtitle2
        ?.copyWith(fontSize: 10, color: Colors.grey);

    final file = widget.message.file;

    final hash = (widget.message.senderDetail?.pk ?? '') +
        (widget.message.senderDetail?.displayName ?? '');
    final colorIndex = hash.hashCode % chatColors.length;
    final nameColor = chatColors[colorIndex];

    Future<void> followHost(BuildContext context) async {
      final userPK = widget.creatorId;

      final response = await context
          .read(creatorStateProvider('').notifier)
          .followCreator(userPK, context);

      response.fold(
        (failure) {
          setState(() {
            isFollowing = !isFollowing;
            widget.message.isFollowing = isFollowing;
          });
          // Fluttertoast.showToast(msg: failure.message.toString());
        },
        (request) {
          setState(() {
            isFollowing = !isFollowing;
            widget.message.isFollowing = isFollowing;
          });

          final analytics = KiwiContainer().resolve<Analytics>();
          analytics.trackEvent(
              eventName: AnalyticsEvents.followCreator, properties: {});

          // Fluttertoast.showToast(msg: '');
        },
      );
    }

    Future<void> inviteFriends(BuildContext context) async {
      final url =
          'https://crater.club/session/${widget.conversationId}?utm_source=in_app_share&referrer_id=${widget.user.pk}&utm_campaign=mobile_app';
      shareApp(context, url, '');
    }

    Future<void> exploreStreams(BuildContext context) async {
      await manageRSVPPopup(context, '', slide: 2);
    }

    Future<void> performAction(BuildContext context) async {
      switch (widget.message.action) {
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
      switch (widget.message.action) {
        case 1:
          actionTitle = isFollowing ? 'Following' : 'Follow';
          break;
        case 2:
          actionTitle = 'Invite';
          break;
        case 3:
          actionTitle = 'Explore';
          break;
      }

      return ((widget.message.action == 1 ||
                  widget.message.action == 2 ||
                  widget.message.action == 3) &&
              (widget.message.message?.isNotEmpty ?? false))
          ? Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).backgroundColor),
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(child: Text(widget.message.message!)),
                  isFollowing
                      ? SizedBox(
                          width: 100,
                          height: 50,
                          child: Center(child: Text(actionTitle)),
                        )
                      : BaseLargeButton(
                          text: actionTitle,
                          onPressed: () => performAction(context))
                ],
              ),
            )
          : null;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: AppInsets.sm, horizontal: AppInsets.xl),
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
                child: (widget.message.type == 3)
                    ? buildActionButton(context)
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                (widget.message.displayName ??
                                        widget
                                            .message.senderDetail?.firstName ??
                                        widget.message.senderDetail?.name ??
                                        '') +
                                    ': ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(
                                        color: HexColor.fromHex(nameColor)),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              if (widget.message.message?.isNotEmpty ?? false)
                                Expanded(child: Text(widget.message.message!))
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
                                      image: imageProvider, fit: BoxFit.cover),
                                ),
                              ),
                            ),
                          if (widget.message.reaction?.file != null)
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
                              imageUrl: widget.message.reaction!.file!,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.contain),
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
                        (widget.message.created as Timestamp?)?.toDate() ??
                            DateTime.now()),
                    style: timeStampStyle,
                  ),
                  Icon(
                    WorkNetIcons.doublecheck,
                    size: 20,
                    color: widget.message.isRead!
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
