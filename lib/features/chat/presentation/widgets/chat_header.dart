import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../constants/theme.dart';
import '../../../chat_inbox/domain/entity/chat_user_entity.dart';

class ChatHeader extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final ChatUser user;

  ChatHeader({
    @required this.expandedHeight,
    @required this.user,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final dateFormat = DateFormat.yMMM();
    final timeFormat = DateFormat.jm();
    final image = user.photo;
    final expandedHeaderStyle = Theme.of(context).textTheme.bodyText2.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w400,
        );
    final expandedSubheadStyle = Theme.of(context).textTheme.bodyText1.copyWith(
          fontSize: 12,
          color: Colors.grey[500],
          fontWeight: FontWeight.w400,
        );
    final date = user.lastSeen != null ? dateFormat.format(user.lastSeen) : "";
    final time = user.lastSeen != null ? timeFormat.format(user.lastSeen) : "";
    final unreadString =
        user.unreadCount != null ? "| Unread: ${user.unreadCount}" : "";
    return Stack(
      fit: StackFit.expand,
      children: [
        if (user != null)
          Container(
            color: Colors.grey[100],
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 36,
                    backgroundImage: NetworkImage(image),
                  ),
                  const SizedBox(height: AppInsets.xl),
                  Text(
                    user.name,
                    style: expandedHeaderStyle,
                  ),
                  const SizedBox(height: AppInsets.sm),
                  Text(
                    "Last seen: $time, $date  $unreadString",
                    style: expandedSubheadStyle,
                  )
                ],
              ),
            ),
          ),
      ],
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => expandedHeight;

  @override
  // TODO: implement minExtent
  double get minExtent => AppTheme.appBarHeight.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
