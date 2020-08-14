import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:worknetwork/blocs/notification/repo/notification_repo.dart';
import 'package:worknetwork/blocs/websocket/repo/websocket_repository.dart';
import 'package:worknetwork/models/websocket/response/ws_response.dart';

import '../../../models/chat/chat_model.dart';

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
      if (type == WSResponseType.getUserNotification) {
        final response = WSGetUserNotificatioResponse.fromJson(json);
        // print(json);
        add(UserNotificationLoaded(response: response));
      }
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
    if (event is OpenNotificationHiveStarted) {
      _notificationRepository.getNotificationsFromBox();
    }
    // Loaded Evetns
    if (event is UserNotificationLoaded) {
      yield* _mapNotificationToState(event);
    }
  }

  Stream<NotificationState> _mapNotificationToState(
      UserNotificationLoaded event) async* {
    final notification = MessageNotification.fromResponse(event.response);
    yield MessageNotificationPersisted(notification: notification);
    final allNotifications =
        await _notificationRepository.setNotificationToBox(notification);
    yield MessageNotificationLoaded(
      notification: notification,
      messageNotifcations: allNotifications,
    );
  }
}
