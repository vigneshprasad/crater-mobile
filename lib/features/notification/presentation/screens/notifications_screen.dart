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
  final _pageSize = 10;
  int _currentPage = 1;
  List<Notification> _notifications = [];
  // ignore: unused_field
  late NotificationBloc _bloc;

  @override
  void initState() {
    _bloc = BlocProvider.of<NotificationBloc>(context)
      ..add(GetNotificationsRequestStarted(
        page: _currentPage,
        pageSize: _pageSize,
      ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationBloc, NotificationState>(
      listener: _notificationBlocListener,
      builder: (context, state) {
        return NotificationScreenLayout(
          itemBuilder: (context, index) {
            return NotificationListItem(notification: _notifications[index]);
          },
          itemCount: _notifications.length,
        );
      },
    );
  }

  void _notificationBlocListener(
      BuildContext context, NotificationState state) {
    if (state is GetNotificationsReceived) {
      setState(() {
        _currentPage = state.currentPage!;
        _notifications = [..._notifications, ...state.notifications!];
      });
    }
  }
}
