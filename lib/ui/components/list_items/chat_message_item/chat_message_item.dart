import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../../../constants/theme.dart';
import '../../../../constants/work_net_icons_icons.dart';
import '../../../../features/auth/domain/entity/user_entity.dart';
import '../../../../features/chat/domain/entity/chat_message_entity.dart';

class ChatMessageItem extends StatelessWidget {
  final User user;
  final ChatMessage message;

  const ChatMessageItem({
    Key? key,
    required this.user,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat.jm();
    final bool isSender = user.pk == message.senderId;
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

    final file = message.file;
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message.displayName ?? message.senderDetail?.name ?? '',
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Theme.of(context).accentColor),
                      ),
                      const SizedBox(height: 4,),
                      if (message.message?.isNotEmpty ?? false)
                        Text(message.message!),
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
                          imageBuilder: (context, imageProvider) => Container(
                            width: imageWidth,
                            height: imageHeight,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
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
                          imageBuilder: (context, imageProvider) => Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.contain),
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
                    dateFormat.format((message.created as Timestamp?)?.toDate() ?? DateTime.now()),
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
