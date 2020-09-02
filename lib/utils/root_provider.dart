import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';
import 'package:worknetwork/core/features/websocket/presentation/bloc/websocket_bloc.dart';
import 'package:worknetwork/features/notification/presentation/bloc/notification_bloc.dart';

import '../features/auth/presentation/bloc/auth_bloc.dart';

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

  @override
  void initState() {
    _authBloc = KiwiContainer().resolve<AuthBloc>();
    _websocketBloc = KiwiContainer().resolve<WebsocketBloc>();
    _notificationBloc = KiwiContainer().resolve<NotificationBloc>();
    super.initState();
  }

  @override
  void dispose() {
    _authBloc.close();
    _websocketBloc.close();
    _notificationBloc.close();
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
        // BlocProvider(
        //   lazy: false,
        //   create: (context) =>
        //       NotificationBloc(webSocketRepository: webSocketRepository)
        //         ..add(const OpenNotificationHiveStarted()),
        // ),
        BlocProvider.value(
          value: _notificationBloc,
        )
      ],
      child: widget.child,
    );
  }
}
