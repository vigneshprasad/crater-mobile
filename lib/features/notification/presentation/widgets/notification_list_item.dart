import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:worknetwork/constants/app_constants.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/features/notification/domain/entity/notification_entity.dart';

class NotificationListItem extends StatelessWidget {
  final Notification notification;

  const NotificationListItem({
    Key key,
    @required this.notification,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final notificationTextStyle =
        Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.grey[700]);
    return Column(
      children: [
        ListTile(
          leading: _buildNotificationImage(),
          isThreeLine: true,
          dense: true,
          title: _buildTitle(context),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: AppInsets.sm),
            child: Text(
              notification.text,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: notificationTextStyle,
            ),
          ),
          onTap: () {},
        ),
        const Divider(indent: AppInsets.listDividerInset)
      ],
    );
  }

  Widget _buildTitle(BuildContext context) {
    final authorTestStyle = Theme.of(context).textTheme.subtitle2.copyWith(
          fontSize: 14,
        );
    final softStyle = authorTestStyle.copyWith(
      color: Colors.grey,
      fontWeight: FontWeight.w400,
    );
    return RichText(
      text: TextSpan(children: [
        TextSpan(text: notification.authorName, style: authorTestStyle),
        TextSpan(
            text: " created an ${notification.objType} ", style: softStyle),
      ]),
    );
  }

  Widget _buildNotificationImage() {
    if (notification.authAvatar == null) {
      return const CircleAvatar(
        backgroundImage: AppImageAssets.defaultAvatar,
      );
    } else {
      return CachedNetworkImage(
        imageUrl: notification.authAvatar,
        imageBuilder: (context, imageProvider) {
          return CircleAvatar(
            backgroundImage: imageProvider,
          );
        },
      );
    }
  }
}
