import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';

import '../blocs/notification/bloc/notification_bloc.dart';
import '../blocs/websocket/bloc/websocket_bloc.dart';
import '../blocs/websocket/repo/websocket_repository.dart';
import '../features/auth/presentation/bloc/auth_bloc.dart';

class RootProvider extends StatelessWidget {
  final Widget child;
  final AuthBloc _authBloc = KiwiContainer().resolve<AuthBloc>();
  final WebSocketRepository webSocketRepository = WebSocketRepository();

  RootProvider({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [RepositoryProvider.value(value: webSocketRepository)],
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: _authBloc,
          ),
          BlocProvider(
            lazy: false,
            create: (context) => WebsocketBloc(
              authBloc: _authBloc,
              webSocketRepository: webSocketRepository,
            ),
          ),
          BlocProvider(
            lazy: false,
            create: (context) =>
                NotificationBloc(webSocketRepository: webSocketRepository)
                  ..add(const OpenNotificationHiveStarted()),
          ),
        ],
        child: child,
      ),
    );
  }
}
