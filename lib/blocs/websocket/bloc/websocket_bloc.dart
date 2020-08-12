import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:worknetwork/blocs/auth/bloc/auth_bloc.dart';
import 'package:worknetwork/blocs/websocket/repo/websocket_repository.dart';

part 'websocket_event.dart';
part 'websocket_state.dart';

class WebsocketBloc extends Bloc<WebsocketEvent, WebsocketState> {
  final WebSocketRepository webSocketRepository;
  final AuthBloc authBloc;
  StreamSubscription authBlocSubscription;

  WebsocketBloc({
    @required this.authBloc,
    @required this.webSocketRepository,
  }) : super(WebsocketInitial()) {
    authBlocSubscription ??= authBloc.listen((state) {
      if (state is AuthStateSuccess) {
        add(ConnectWebsocket());
      }
    });
  }

  @override
  Stream<WebsocketState> mapEventToState(
    WebsocketEvent event,
  ) async* {
    if (event is ConnectWebsocket) {
      yield* _mapConnectWebsocket();
    }
  }

  Stream<WebsocketState> _mapConnectWebsocket() async* {
    try {
      await webSocketRepository.initSocket();
      yield const WebSocketConnected();
    } catch (error) {
      yield WebSocketConnectFailed(error: error);
    }
  }

  @override
  Future<void> close() {
    authBlocSubscription.cancel();
    return super.close();
  }
}
