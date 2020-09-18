import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'package:worknetwork/core/features/websocket/domain/usecase/add_message_to_sink.dart';
import 'package:worknetwork/core/features/websocket/domain/usecase/close_websocket_connection.dart';
import 'package:worknetwork/core/features/websocket/domain/usecase/get_websocket_state.dart';
import 'package:worknetwork/core/features/websocket/domain/usecase/websocket_connect_usecase.dart';
import 'package:worknetwork/core/usecase/aysnc_usecase.dart';
import 'package:worknetwork/features/auth/presentation/bloc/auth_bloc.dart';

part 'websocket_event.dart';
part 'websocket_state.dart';

class WebsocketBloc extends Bloc<WebsocketEvent, WebsocketState> {
  final UCWebSocketGetConnection connectionState;
  final UCWebsocketConnect connect;
  final UCWebSocketAddToSink addToSink;
  final UCWebSocketClose socketClose;
  final AuthBloc authBloc;
  StreamSubscription _authBlocSub;

  WebsocketBloc({
    @required this.connectionState,
    @required this.connect,
    @required this.addToSink,
    @required this.authBloc,
    @required this.socketClose,
  }) : super(WebsocketInitial()) {
    _authBlocSub ??= authBloc.listen((authState) {
      if (authState is AuthStateSuccess) {
        if (state is! WebSocketConnected) {
          add(const WebSocketInitConnect());
        }
      }
    });
  }

  @override
  Future<void> close() {
    _authBlocSub?.cancel();
    return super.close();
  }

  @override
  Stream<WebsocketState> mapEventToState(
    WebsocketEvent event,
  ) async* {
    if (event is WebSocketInitConnect) {
      yield* _mapWebSocketeConnectToState(event);
    } else if (event is WebSocketCloseStarted) {
      yield* _mapWebSocketCloseToState(event);
    }
  }

  Stream<WebsocketState> _mapWebSocketeConnectToState(
      WebSocketInitConnect event) async* {
    yield const WebSocketConnectLoading();
    final connectOrError = await connect(NoParams());
    yield connectOrError.fold(
      (failure) => const WebSocketDisconnected(),
      (connection) => WebSocketConnected(
        channel: connection.channel,
        controller: connection.streamController,
      ),
    );
  }

  Stream<WebsocketState> _mapWebSocketCloseToState(
      WebSocketCloseStarted event) async* {
    final closeOrFail = await socketClose(NoParams());
    yield closeOrFail.fold(
      (failure) => WebSocketError(failure),
      (r) => const WebSocketDisconnected(),
    );
  }
}
