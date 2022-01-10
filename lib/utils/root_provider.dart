import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';

import '../core/features/websocket/presentation/bloc/websocket_bloc.dart';
import '../features/article/presentation/bloc/article_bloc.dart';
import '../features/auth/presentation/bloc/auth_bloc.dart';
import '../features/chat_inbox/presentation/bloc/chat_inbox/chat_inbox_bloc.dart';
import '../features/meeting/presentation/bloc/meeting_bloc.dart';
import '../features/notification/presentation/bloc/notification_bloc.dart';
import '../features/points/presentation/bloc/points_bloc.dart';
import '../features/rewards/presentation/bloc/rewards_bloc.dart';

class RootProvider extends StatefulWidget {
  final Widget child;

  const RootProvider({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  _RootProviderState createState() => _RootProviderState();
}

class _RootProviderState extends State<RootProvider> {
  late AuthBloc _authBloc;
  // late WebsocketBloc _websocketBloc;
  late NotificationBloc _notificationBloc;
  late MeetingBloc _meetingBloc;
  late RewardsBloc _rewardsBloc;
  late PointsBloc _pointsBloc;
  late ChatInboxBloc _chatInboxBloc;
  late ArticleBloc _articleBloc;

  @override
  void initState() {
    _authBloc = KiwiContainer().resolve<AuthBloc>();
    // _websocketBloc = KiwiContainer().resolve<WebsocketBloc>();
    _notificationBloc = KiwiContainer().resolve<NotificationBloc>();
    _meetingBloc = KiwiContainer().resolve<MeetingBloc>();
    _rewardsBloc = KiwiContainer().resolve<RewardsBloc>();
    _pointsBloc = KiwiContainer().resolve<PointsBloc>();
    _chatInboxBloc = KiwiContainer().resolve<ChatInboxBloc>();
    _articleBloc = KiwiContainer().resolve<ArticleBloc>();
    super.initState();
  }

  @override
  void dispose() {
    _authBloc.close();
    // _websocketBloc.close();
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
        // BlocProvider.value(
        //   value: _websocketBloc,
        // ),
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
        ),
        BlocProvider.value(
          value: _chatInboxBloc,
        ),
        BlocProvider.value(
          value: _articleBloc,
        )
      ],
      child: widget.child,
    );
  }
}
