import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/features/websocket/data/models/ws_response.dart';
import '../../../../core/features/websocket/presentation/bloc/websocket_bloc.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../../../chat_inbox/domain/entity/chat_user_entity.dart';
import '../../data/models/responses.dart';
import '../../domain/entity/chat_message_entity.dart';
import '../../domain/usecases/persist_received_message.dart';
import '../../domain/usecases/received_set_chat_with_user.dart';
import '../../domain/usecases/send_message_to_user_usecase.dart';
import '../../domain/usecases/send_read_user_messaged.dart';
import '../../domain/usecases/send_user_typing.dart';
import '../../domain/usecases/set_chat_with_user_usecase.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final WebsocketBloc websocketBloc;
  final UCSetChatWithUser setChatWithUser;
  final UCSendChatToUser sendMessage;
  final UCReceivedSetChatWithUser receivedSetChatWithUser;
  final UCSendUserIsTyping sendUserIsTyping;
  final UCPersistReceivedMessage persistReceivedMessage;
  final UCSendReadUserMessage sendReadUserMessage;

  StreamSubscription _webSocketBlocSub;
  StreamSubscription _streamSubscription;

  ChatBloc({
    @required this.websocketBloc,
    @required this.setChatWithUser,
    @required this.sendMessage,
    @required this.receivedSetChatWithUser,
    @required this.sendUserIsTyping,
    @required this.persistReceivedMessage,
    @required this.sendReadUserMessage,
  })  : assert(websocketBloc != null),
        assert(setChatWithUser != null),
        assert(sendMessage != null),
        assert(receivedSetChatWithUser != null),
        assert(sendUserIsTyping != null),
        assert(persistReceivedMessage != null),
        assert(sendReadUserMessage != null),
        super(const ChatInitial()) {
    if (websocketBloc.state is WebSocketConnected) {
      add(const WebSocketBlocConnected());
    } else {
      _webSocketBlocSub ??= websocketBloc.listen((websocketBlocState) {
        if (websocketBlocState is WebSocketDisconnected) {
          add(const WebSocketBlocConnected());
        }
      });
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    _webSocketBlocSub?.cancel();
    return super.close();
  }

  @override
  Stream<ChatState> mapEventToState(
    ChatEvent event,
  ) async* {
    if (event is WebSocketBlocConnected) {
      _mapStreamToEvents();
      yield const ChatWebSocketReady();
    } else if (event is SetChatWithUserStarted) {
      yield* _mapSetChatStartedToState(event);
    } else if (event is SendUserIsTypingRequest) {
      yield* _mapSendUserIsTypingToState(event);
    } else if (event is SendChatMessageStarted) {
      yield* _mapSendChatMessageToState(event);
    }

    // Responses from Socket Stream
    if (event is ReceivedSetChatUserResponse) {
      yield* _mapRecievedSetChatToState(event);
    } else if (event is ReceivedChatMessageResponse) {
      yield* _mapReceivedMessageToState(event);
    }
  }

  void _mapStreamToEvents() {
    final socketState = websocketBloc.state as WebSocketConnected;
    _streamSubscription ??= socketState.controller.stream.listen((snapShot) {
      final json = jsonDecode(snapShot.toString()) as Map<String, dynamic>;
      final type = WSResponse.getEnumFromJson(json["type"]);

      if (type == WSResponseType.loadChatMessages) {
        final response = SetChatUserResponse.fromJson(json);
        sendReadUserMessage(NoParams());
        add(ReceivedSetChatUserResponse(response: response));
      }
      if (type == WSResponseType.getUserMessage) {
        final response = SentMessageResponse.fromJson(json);
        add(ReceivedChatMessageResponse(
          message: response.toChatMessage(),
          chatKey: response.receiverId,
        ));
      } else if (type == WSResponseType.getUserNotification) {
        final response = ChatMessageNotificationResponse.fromJson(json);
        if (response.senderId == state.receiverUser.pk) {
          add(ReceivedChatMessageResponse(
            message: response.latestMessage,
            chatKey: response.senderId,
          ));
        }
      }
    });
  }

  Stream<ChatState> _mapSetChatStartedToState(
      SetChatWithUserStarted event) async* {
    final cacheOrError =
        await setChatWithUser(SetChatParams(receiverId: event.recieverId));
    yield cacheOrError.fold(
      (failure) => state.copyWith(error: failure),
      (userState) => state.copyWith(
        recieverId: userState.recieverId,
        receiverUser: userState.receiverUser,
        messages: userState.messages.toList(),
        page: userState.page,
        pages: userState.pages,
        unreadCount: userState.unreadCount,
      ),
    );
  }

  Stream<ChatState> _mapRecievedSetChatToState(
      ReceivedSetChatUserResponse event) async* {
    final cachedOrError = await receivedSetChatWithUser(ReceivedSetChatParams(
      messages: event.response.results,
      receiverUser: event.response.userData,
      page: event.response.page,
      pages: event.response.pages,
      unreadCount: event.response.userData.unreadCount,
    ));
    yield cachedOrError.fold(
      (failure) => state.copyWith(error: failure),
      (userState) => state.copyWith(
          recieverId: userState.recieverId,
          receiverUser: userState.receiverUser,
          messages: userState.messages.toList(),
          page: userState.page,
          pages: userState.pages,
          unreadCount: userState.unreadCount),
    );
  }

  Stream<ChatState> _mapSendUserIsTypingToState(
      SendUserIsTypingRequest event) async* {
    final sendOrFail = await sendUserIsTyping(NoParams());
    yield sendOrFail.fold(
      (failure) => state.copyWith(error: failure),
      // ignore: avoid_redundant_argument_values
      (val) => state.copyWith(error: null),
    );
  }

  Stream<ChatState> _mapSendChatMessageToState(
      SendChatMessageStarted event) async* {
    final sendOrFail =
        await sendMessage(SendChatParams(message: event.message));
    yield sendOrFail.fold(
      (failure) => state.copyWith(error: failure),
      (r) =>
          // ignore: avoid_redundant_argument_values
          state.copyWith(error: null),
    );
  }

  Stream<ChatState> _mapReceivedMessageToState(
      ReceivedChatMessageResponse event) async* {
    yield state.copyWith(loading: true);
    final cachedOrFailed = await persistReceivedMessage(ReceivedMessageParams(
      message: event.message,
      chatKey: event.chatKey,
    ));
    yield cachedOrFailed.fold(
      (failure) => state.copyWith(error: failure, loading: false),
      (message) {
        final messages = [message, ...state.messages];
        return ChatMessagePersisted(
          recieverId: state.recieverId,
          receiverUser: state.receiverUser,
          page: state.page,
          pages: state.pages,
          messages: messages,
          unreadCount: state.unreadCount,
          error: state.error,
        );
      },
    );
  }
}
