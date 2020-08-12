import 'package:flutter/material.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/constants/work_net_icons_icons.dart';

import 'package:worknetwork/models/chat/chat_model.dart';
import 'package:worknetwork/models/user/user_model.dart';

class ChatMessageItem extends StatelessWidget {
  final User user;
  final ChatMessage message;

  const ChatMessageItem({
    Key key,
    @required this.user,
    @required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isSender = user.pk == message.senderId;
    const radius = Radius.circular(12.0);
    const senderBorderRadius = BorderRadius.only(
        topLeft: radius, topRight: radius, bottomLeft: radius);
    const recieverBorderRadius = BorderRadius.only(
        topLeft: radius, topRight: radius, bottomRight: radius);
    final testStyle = Theme.of(context).textTheme.bodyText1.copyWith(
          fontSize: 14,
          color: isSender ? Colors.white : Colors.grey[800],
        );
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: AppInsets.med, horizontal: AppInsets.xl),
      child: Column(
        children: [
          Container(
            alignment: isSender ? Alignment.topRight : Alignment.topLeft,
            child: Material(
              color: isSender ? AppTheme.blueAccent : Colors.grey[300],
              borderRadius:
                  isSender ? senderBorderRadius : recieverBorderRadius,
              child: InkWell(
                onTap: () {},
                splashColor: AppTheme.blueAccent.withOpacity(0.4),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: AppInsets.l, horizontal: AppInsets.xl),
                  child: Text(message.message, style: testStyle),
                ),
              ),
            ),
          ),
          if (isSender)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppInsets.sm),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    WorkNetIcons.doublecheck,
                    size: 20,
                    color:
                        message.isRead ? AppTheme.blueAccent : Colors.grey[400],
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}
