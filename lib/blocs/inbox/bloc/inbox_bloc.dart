import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:worknetwork/blocs/inbox/repo/inbox_repository.dart';
import 'package:worknetwork/blocs/notification/bloc/notification_bloc.dart';
import 'package:worknetwork/blocs/websocket/repo/websocket_repository.dart';
import 'package:worknetwork/models/chat/chat_model.dart';
import 'package:worknetwork/models/websocket/response/ws_response.dart';
import 'package:worknetwork/models/websocket/requests/ws_requests.dart';

part 'inbox_event.dart';
part 'inbox_state.dart';

class InboxBloc extends Bloc<InboxEvent, InboxState> {
  final WebSocketRepository webSocketRepository;
  final NotificationBloc notificationBloc;
  InboxRepository _inboxRepository;
  StreamSubscription _inboxSocketSub;
  StreamSubscription _notificationBlocStreamSub;

  // Connect to stream listener
  InboxBloc({
    @required this.webSocketRepository,
    @required this.notificationBloc,
  }) : super(InboxInitial()) {
    _inboxRepository = InboxRepository(webSocketRepository.channel);
    _inboxSocketSub ??=
        webSocketRepository.streamController.stream.listen((snapShot) {
      final json = jsonDecode(snapShot.toString()) as Map<String, dynamic>;
      final WSResponseType type = WSResponse.getEnumFromJson(json["type"]);

      if (type == WSResponseType.loadAllUsers) {
        add(InboxGetAllUsersLoaded(
            response: WSGetAllUsersResponse.fromJson(json)));
      }

      _notificationBlocStreamSub ??= notificationBloc.listen((state) {
        if (state is MessageNotificationLoaded) {
          add(ChatUserNotificationLoaded(notification: state.notification));
        }
      });
    });
  }

  @override
  Future<void> close() {
    _notificationBlocStreamSub?.cancel();
    _inboxSocketSub.cancel();
    return super.close();
  }

  @override
  Stream<InboxState> mapEventToState(
    InboxEvent event,
  ) async* {
    if (event is InboxGetAllUsers) {
      _inboxRepository.getAllUsersRequest(event.request);
    }

    // Socket Stream onResponse Events
    if (event is InboxGetAllUsersLoaded) {
      yield* _mapAllUserstoState(event);
    } else if (event is ChatUserNotificationLoaded) {
      yield* _mapNotificationToState(event);
    }
  }

  Stream<InboxState> _mapAllUserstoState(InboxGetAllUsersLoaded event) async* {
    final response = event.response;
    yield PersistChatUsers(users: event.response.results);
    final users =
        await _inboxRepository.persistChatUsers(event.response.results);
    yield AllUsersLoaded(
      page: response.page,
      pages: response.pages,
      users: users,
    );
  }

  Stream<InboxState> _mapNotificationToState(
      ChatUserNotificationLoaded event) async* {
    final users = await _inboxRepository.updateChatUserData(event.notification);
    yield UpdatedUserData(notification: event.notification);
    yield AllUsersLoaded(
      page: state.page,
      pages: state.pages,
      users: users,
    );
  }
}
