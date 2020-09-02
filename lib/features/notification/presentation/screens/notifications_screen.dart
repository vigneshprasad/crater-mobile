import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entity/notification_entity.dart';
import '../bloc/notification_bloc.dart';
import '../widgets/notification_list_item.dart';
import '../widgets/notification_screen_layout.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  int _currentPage = 1;
  int _pages = 1;
  List<Notification> notifications = [];
  NotificationBloc _bloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationBloc, NotificationState>(
      listener: (context, state) {},
      builder: (context, state) {
        return NotificationScreenLayout(
          itemBuilder: (context, index) {
            return NotificationListItem(
                notification: state.notifications[index]);
          },
          itemCount: state.notifications.length,
        );
      },
    );
  }
}
