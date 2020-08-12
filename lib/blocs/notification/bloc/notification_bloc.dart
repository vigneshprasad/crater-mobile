import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:worknetwork/blocs/notification/repo/notification_repo.dart';
import 'package:worknetwork/blocs/websocket/repo/websocket_repository.dart';
import 'package:worknetwork/models/websocket/response/ws_response.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final WebSocketRepository webSocketRepository;
  NotificationRepository _notificationRepository;
  StreamSubscription _notificationSocketSub;

  NotificationBloc({@required this.webSocketRepository})
      : super(const NotificationInitial()) {
    _notificationRepository =
        NotificationRepository(webSocketRepository.channel);
    _notificationSocketSub ??=
        webSocketRepository.streamController.stream.listen((snapShot) {
      final json = jsonDecode(snapShot.toString()) as Map<String, dynamic>;
      final WSResponseType type = WSResponse.getEnumFromJson(json["type"]);
      if (type == WSResponseType) {}
    });
  }

  @override
  Future<void> close() {
    _notificationSocketSub?.cancel();
    return super.close();
  }

  @override
  Stream<NotificationState> mapEventToState(
    NotificationEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
