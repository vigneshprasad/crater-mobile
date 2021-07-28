import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:kiwi/kiwi.dart';

import '../../../../constants/app_constants.dart';
import '../../../../features/chat/domain/entity/chat_message_entity.dart';
import '../../../../features/chat_inbox/domain/entity/chat_user_entity.dart';
import '../../../../routes.gr.dart';
import '../../../base/base_badge/base_badge.dart';

class UserListItem extends StatelessWidget {
  final ChatUser user;
  final bool withFavorite;
  final VoidCallback? onStarPressed;
  final GlobalKey<NavigatorState> _navigatorKey =
      KiwiContainer().resolve<GlobalKey<NavigatorState>>();

  UserListItem({
    Key? key,
    required this.user,
    this.onStarPressed,
    this.withFavorite = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Material(
      child: InkWell(
        onTap: () => _navigatorKey.currentState?.pushNamed(
          ChatScreenRoute.name,
          arguments: ChatScreenRouteArgs(recieverId: user.pk ?? ''),
        ),
        child: ListTile(
          dense: true,
          leading: _buildAvatarImage(),
          title: Text(
            user.name ?? '',
            style: textTheme.subtitle1,
          ),
          subtitle:
              getLastMessageString(user.latestMessage, textTheme.bodyText2!),
          trailing: _buildListActions(),
        ),
      ),
    );
  }

  Widget getLastMessageString(ChatMessage? message, TextStyle style) {
    if (message != null) {
      final bool userIsCreator = user.pk == message.receiverId;
      final String senderName = userIsCreator ? "You" : message.sender!;
      return Text(
        "$senderName: ${message.message}",
        style: style.copyWith(color: Colors.grey[500]),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      );
    }
    return const Text("");
  }

  Widget _buildAvatarImage() {
    if (user.photo != null) {
      return CachedNetworkImage(
        imageUrl: user.photo!,
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

  Widget? _buildListActions() {
    if (withFavorite) {
      final icon = user.isStarred ?? false ? Icons.star : Icons.star_border;
      return IconButton(
        onPressed: onStarPressed,
        icon: Icon(icon),
        color: Colors.yellow[800],
      );
    }
    return null;
  }
}
