import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:worknetwork/constants/app_constants.dart';
import 'package:worknetwork/models/chat/chat_model.dart';
import 'package:worknetwork/routes.dart';
import 'package:worknetwork/ui/base/base_badge/base_badge.dart';

class UserListItem extends StatelessWidget {
  final ChatUser user;
  final bool withFavorite;

  const UserListItem({
    Key key,
    @required this.user,
    this.withFavorite = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Material(
      child: InkWell(
        onTap: () => Navigator.of(context)
            .pushNamed(Routes.chatUser, arguments: user.pk),
        child: ListTile(
          dense: true,
          leading: _buildAvatarImage(),
          title: Text(
            user.name,
            style: textTheme.subtitle1,
          ),
          subtitle:
              getLastMessageString(user.latestMessage, textTheme.bodyText2),
          trailing: _buildListActions(),
        ),
      ),
    );
  }

  Widget getLastMessageString(ChatMessage message, TextStyle style) {
    final bool userIsCreator = user.pk == message.receiverId;
    final String senderName = userIsCreator ? "You" : message.sender;
    return Text(
      "$senderName: ${message.message}",
      style: style.copyWith(color: Colors.grey[500]),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }

  Widget _buildAvatarImage() {
    if (user.photo != null) {
      return CachedNetworkImage(
        imageUrl: user.photo,
        imageBuilder: (context, imageProvider) {
          return BaseBadge(
            count: user.unreadCount ?? 0,
            child: CircleAvatar(
              backgroundImage: imageProvider,
            ),
          );
        },
      );
    }
    return const CircleAvatar(
      backgroundImage: AppImageAssets.defaultAvatar,
    );
  }

  Widget _buildListActions() {
    if (withFavorite) {
      final icon = user.isStarred ? Icons.star : Icons.star_border;
      return IconButton(
        onPressed: () {},
        icon: Icon(icon),
        color: Colors.yellow[800],
      );
    }
    return null;
  }
}
