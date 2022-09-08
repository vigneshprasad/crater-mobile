import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/constants/work_net_icons_icons.dart';
import 'package:worknetwork/core/color/color.dart';
import 'package:worknetwork/features/auth/domain/entity/user_entity.dart';
import 'package:worknetwork/features/chat/data/models/chat_message_model.dart';
import 'package:worknetwork/features/connection/data/models/creator_response.dart';

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
  final Creator creator;

  ChatMessageItem({
    Key? key,
    this.user,
    required this.message,
    required this.conversationId,
    required this.creator,
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

    final hash = (message.senderDetails?.pk ?? '') +
        (message.senderDetails?.displayName ?? '');
    final colorIndex = hash.hashCode % chatColors.length;
    final nameColor = chatColors[colorIndex];

    const radius = Radius.circular(8);

    var name = message.displayName?.trim() ?? '';

    if (name.isEmpty) {
      name = message.senderDetails?.displayName?.trim() ?? '';
    }

    if (name.isEmpty) {
      name = message.senderDetails?.firstName?.trim() ?? '';
    }

    if (name.isEmpty) {
      name = message.senderDetails?.name.trim() ?? '';
    }

    final chatBubbleMaxWidth = MediaQuery.of(context).size.width * 0.6;

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 16,
      ),
      child: (message.type == 3)
          ? Container()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: isSender ? Alignment.topRight : Alignment.topLeft,
                  // child:
                  // Material(
                  //   elevation: 1,

                  // borderRadius:
                  //     isSender ? senderBorderRadius : recieverBorderRadius,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {},
                        splashColor: AppTheme.blueAccent.withOpacity(0.4),
                        borderRadius: const BorderRadius.only(
                          topLeft: radius,
                          topRight: radius,
                          bottomRight: radius,
                        ),
                        child: Container(
                          // padding: const EdgeInsets.symmetric(
                          //     vertical: AppInsets.l, horizontal: AppInsets.l),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).dialogBackgroundColor,
                            borderRadius: const BorderRadius.only(
                              topLeft: radius,
                              topRight: radius,
                              bottomRight: radius,
                            ),
                          ),

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '$name: ',
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
                                  ConstrainedBox(
                                    constraints: BoxConstraints(
                                        maxWidth: chatBubbleMaxWidth),
                                    child: Text(message.message ?? ''),
                                  ),
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
                              if (message.data?.reaction?.file != null)
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
                                  imageUrl: message.data!.reaction!.file!,
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
                    ],
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
