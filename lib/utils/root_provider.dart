import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';

import '../core/features/websocket/presentation/bloc/websocket_bloc.dart';
import '../features/auth/presentation/bloc/auth_bloc.dart';
import '../features/meeting/presentation/bloc/meeting_bloc.dart';
import '../features/notification/presentation/bloc/notification_bloc.dart';
import '../features/points/presentation/bloc/points_bloc.dart';
import '../features/rewards/presentation/bloc/rewards_bloc.dart';

class RootProvider extends StatefulWidget {
  final Widget child;

  const RootProvider({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  _RootProviderState createState() => _RootProviderState();
}

class _RootProviderState extends State<RootProvider> {
  AuthBloc _authBloc;
  WebsocketBloc _websocketBloc;
  NotificationBloc _notificationBloc;
  MeetingBloc _meetingBloc;
  RewardsBloc _rewardsBloc;
  PointsBloc _pointsBloc;

  @override
  void initState() {
    _authBloc = KiwiContainer().resolve<AuthBloc>();
    _websocketBloc = KiwiContainer().resolve<WebsocketBloc>();
    _notificationBloc = KiwiContainer().resolve<NotificationBloc>();
    _meetingBloc = KiwiContainer().resolve<MeetingBloc>();
    _rewardsBloc = KiwiContainer().resolve<RewardsBloc>();
    _pointsBloc = KiwiContainer().resolve<PointsBloc>();
    super.initState();
  }

  @override
  void dispose() {
    _authBloc.close();
    _websocketBloc.close();
    _notificationBloc.close();
    _meetingBloc.close();
    _rewardsBloc.close();
    _pointsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: _authBloc,
        ),
        BlocProvider.value(
          value: _websocketBloc,
        ),
        BlocProvider.value(
          value: _meetingBloc,
        ),
        BlocProvider.value(
          value: _notificationBloc,
        ),
        BlocProvider.value(
          value: _rewardsBloc,
        ),
        BlocProvider.value(
          value: _pointsBloc,
        )
      ],
      child: widget.child,
    );
  }
}
