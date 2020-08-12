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

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final NotificationBloc notificationBloc;
  final WebSocketRepository webSocketRepository;
  ChatRepository _chatRepository;
  StreamSubscription _chatSocketSub;
  StreamSubscription _notificationBlocStreamSub;

  ChatBloc({
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
      }
    });

    // Listen Notifcation Bloc for messages
    _notificationBlocStreamSub ??= notificationBloc?.listen((event) {});
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
      _chatRepository.setChatWithUser(event.recieverId);
    } else if (event is SendMessageToUser) {
      _chatRepository.sendMessageToUser(event.message);
    } else if (event is SendUserIsTyping) {
      _chatRepository.senduserIsTyping();
    }

    // WS Response Events
    if (event is SetChatLoaded) {
      yield* _mapChatLoadedToState(event);
    }
  }

  Stream<ChatState> _mapChatLoadedToState(SetChatLoaded event) async* {
    final response = event.response;
    yield SetChatUpdated(
      messages: response.results,
      page: response.page,
      pages: response.pages,
      recieverUser: response.userData,
    );
  }
}
