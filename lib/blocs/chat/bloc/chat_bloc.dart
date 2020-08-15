import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:worknetwork/blocs/chat/repo/chat_repository.dart';
import 'package:worknetwork/blocs/notification/bloc/notification_bloc.dart';
import 'package:worknetwork/blocs/websocket/repo/websocket_repository.dart';
import 'package:worknetwork/models/chat/chat_model.dart';
import 'package:worknetwork/models/websocket/response/ws_response.dart';

import '../../../models/websocket/response/ws_response.dart';
import '../../notification/bloc/notification_bloc.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final String recieverId;
  final NotificationBloc notificationBloc;
  final WebSocketRepository webSocketRepository;
  ChatRepository _chatRepository;
  StreamSubscription _chatSocketSub;
  StreamSubscription _notificationBlocStreamSub;

  ChatBloc({
    @required this.recieverId,
    @required this.webSocketRepository,
    @required this.notificationBloc,
  }) : super(const ChatInitial()) {
    // Listen to websocket bloc
    _chatRepository = ChatRepository(webSocketRepository.channel);

    _chatSocketSub ??=
        webSocketRepository.streamController.stream.listen((snapShot) {
      final json = jsonDecode(snapShot.toString()) as Map<String, dynamic>;
      final WSResponseType type = WSResponse.getEnumFromJson(json["type"]);

      if (type == WSResponseType.loadChatMessages) {
        final response = WSGetChatMessagesResponse.fromJson(json);
        add(SetChatLoaded(response: response));
      } else if (type == WSResponseType.getUserMessage) {
        final message = ChatMessage.fromJson(json);
        add(ChatMessageLoaded(message: message));
      }
    });

    // Listen Notifcation Bloc for messages
    _notificationBlocStreamSub ??= notificationBloc?.listen((state) {
      if (state is MessageNotificationLoaded) {
        final notification = state.notification;
        if (notification.senderId == recieverId) {
          add(ChatReadMessages());

          // add(ChatNotificationLoaded(notification: notification));
        }
      }
    });
  }

  @override
  Future<void> close() {
    _notificationBlocStreamSub?.cancel();
    _chatSocketSub?.cancel();
    return super.close();
  }

  @override
  Stream<ChatState> mapEventToState(
    ChatEvent event,
  ) async* {
    if (event is SetChatWithUser) {
      yield* _mapIntialDatafromHive(event);
    } else if (event is SendMessageToUser) {
      _chatRepository.sendMessageToUser(event.message);
    } else if (event is SendUserIsTyping) {
      _chatRepository.senduserIsTyping();
    } else if (event is ChatReadMessages) {
      _chatRepository.channel.sink
          .add(jsonEncode({"type": "user_read_user_messages"}));
    }

    // WS Response Events
    if (event is SetChatLoaded) {
      yield* _mapChatLoadedToState(event);
    } else if (event is ChatMessageLoaded) {
      yield* _mapChatMessagetoState(event);
    } else if (event is ChatNotificationLoaded) {
      yield* _mapNotificationToState(event);
    }
  }

  Stream<ChatState> _mapIntialDatafromHive(SetChatWithUser event) async* {
    final data = await _chatRepository.getInitialState(event.recieverId);
    if (data != null && data.isInBox) {
      yield SetChatInitalFromPersist(
        messages: data.messages,
        recieverUser: data.recieverUser,
        page: data.page,
        pages: data.pages,
      );
    } else {
      yield const ChatInitial();
    }

    _chatRepository.setChatWithUser(event.recieverId);
  }

  Stream<ChatState> _mapChatLoadedToState(SetChatLoaded event) async* {
    final UserChatMessagesData newState = await _chatRepository.updateChatState(
      event.response.userData,
      event.response.results,
      event.response.page,
      event.response.pages,
    );
    await _chatRepository.clearUnreadCountPersist(event.response.userData.pk);
    yield SetChatUpdated(
      messages: newState.messages,
      page: newState.page,
      pages: newState.pages,
      recieverUser: newState.recieverUser,
    );
  }

  Stream<ChatState> _mapChatMessagetoState(ChatMessageLoaded event) async* {
    yield ChatMessagePersist(message: event.message);
    final UserChatMessagesData box =
        await _chatRepository.addMessageToBox(event.message, recieverId);
    yield SetChatUpdated(
      recieverUser: box.recieverUser,
      pages: box.page,
      page: box.page,
      messages: box.messages,
    );
  }

  Stream<ChatState> _mapNotificationToState(
      ChatNotificationLoaded event) async* {
    yield ChatNotificationPersist(notification: event.notification);
    final UserChatMessagesData box = await _chatRepository.addMessageToBox(
        event.notification.latestMessage, recieverId);
    yield SetChatUpdated(
      recieverUser: box.recieverUser,
      pages: box.page,
      page: box.page,
      messages: box.messages,
    );
  }
}
