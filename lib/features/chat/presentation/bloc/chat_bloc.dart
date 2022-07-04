import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:worknetwork/features/chat/domain/usecases/send_message_to_webinar.dart';

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
  final UCSendChatToWebinar sendWebinarMessage;
  final UCReceivedSetChatWithUser receivedSetChatWithUser;
  final UCSendUserIsTyping sendUserIsTyping;
  final UCPersistReceivedMessage persistReceivedMessage;
  final UCSendReadUserMessage sendReadUserMessage;

  StreamSubscription? _webSocketBlocSub;
  StreamSubscription? _streamSubscription;

  ChatBloc({
    required this.websocketBloc,
    required this.setChatWithUser,
    required this.sendMessage,
    required this.sendWebinarMessage,
    required this.receivedSetChatWithUser,
    required this.sendUserIsTyping,
    required this.persistReceivedMessage,
    required this.sendReadUserMessage,
  }) : super(const ChatInitial()) {
    // if (websocketBloc.state is WebSocketConnected) {
    //   add(const WebSocketBlocConnected());
    // } else {
    //   _webSocketBlocSub ??= websocketBloc.stream.listen((websocketBlocState) {
    //     if (websocketBlocState is WebSocketConnected) {
    //       add(const WebSocketBlocConnected());
    //     }
    //   });
    // }
  }

  void startWebinarChat(String groupId) {

    // if (websocketBloc.state is WebSocketConnected) {
    //   add(const WebSocketBlocConnected());
    // } else {
    //   _webSocketBlocSub ??= websocketBloc.stream.listen((websocketBlocState) {
    //     if (websocketBloc.state is WebSocketConnected) {
    //       add(const WebSocketBlocConnected());
    //     }
    //   });
    // }

    websocketBloc.startWebinarChat(groupId);
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    _webSocketBlocSub?.cancel();
    websocketBloc.endWebinarChat();
    return super.close();
  }

  @override
  Stream<ChatState> mapEventToState(
    ChatEvent event,
  ) async* {
    if (event is WebSocketBlocConnected) {
      _mapStreamToEvents();
      yield const ChatWebSocketReady();
    // }
    // } else if (event is SetChatWithUserStarted) {
    //   yield* _mapSetChatStartedToState(event);
    // } else if (event is SendUserIsTypingRequest) {
    //   yield* _mapSendUserIsTypingToState(event);
    } else if (event is SendChatMessageStarted) {
      yield* _mapSendWebinarChatMessageToState(event);
    } else if (event is SendChatReactionStarted) {
      yield* _mapSendWebinarChatReactionToState(event);
    }

    // Responses from Socket Stream
    // if (event is ReceivedSetChatUserResponse) {
    //   yield* _mapRecievedSetChatToState(event);
    // } else 
    if (event is ReceivedSetChatWebinarResponse) {
      yield* _mapRecievedSetWebinarChatToState(event);
    } else 
    // if (event is ReceivedChatMessageResponse) {
    //   yield* _mapReceivedMessageToState(event);
    // } else 
    if (event is ReceivedWebinarChatMessageResponse) {
      yield* _mapReceivedWebinarMessageToState(event);
    }
  }

  void _mapStreamToEvents() {
    final socketState = websocketBloc.state as WebSocketConnected;
    _streamSubscription ??= socketState.controller.stream.listen((snapShot) {
      final json = jsonDecode(snapShot.toString()) as Map<String, dynamic>;
      final type = WSResponse.getEnumFromJson(json["type"]);
      
      if (type == WSResponseType.groupMessagesReceived) {
        final response = SetChatWebinarResponse.fromJson(json);
        add(ReceivedSetChatWebinarResponse(response: response));
      } else if (type == WSResponseType.newGroupMessage){
        final response = SentWebinarMessageResponse.fromJson(json);
        add(ReceivedWebinarChatMessageResponse(
          message: response.payload!,
        ));
      }
      else if (type == WSResponseType.loadChatMessages) {
        final response = SetChatUserResponse.fromJson(json);
        sendReadUserMessage(NoParams());
        add(ReceivedSetChatUserResponse(response: response));
      }
      else if (type == WSResponseType.getUserMessage) {
        final response = SentMessageResponse.fromJson(json);
        add(ReceivedChatMessageResponse(
          message: response.toChatMessage(),
          chatKey: response.receiverId!,
        ));
      } else if (type == WSResponseType.getUserNotification) {
        final response = ChatMessageNotificationResponse.fromJson(json);
        if (response.senderId == state.receiverUser?.pk) {
          add(ReceivedChatMessageResponse(
            message: response.latestMessage!,
            chatKey: response.senderId!,
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
        messages: userState.messages?.toList(),
        page: userState.page,
        pages: userState.pages,
        unreadCount: userState.unreadCount,
      ),
    );
  }

  Stream<ChatState> _mapRecievedSetChatToState(
      ReceivedSetChatUserResponse event) async* {
    final cachedOrError = await receivedSetChatWithUser(ReceivedSetChatParams(
      messages: event.response.results ?? [],
      receiverUser: event.response.userData ?? ChatUser(),
      page: event.response.page ?? 0,
      pages: event.response.pages ?? 0,
      unreadCount: event.response.userData?.unreadCount ?? 0,
    ));
    yield cachedOrError.fold(
      (failure) => state.copyWith(error: failure),
      (userState) => state.copyWith(
          recieverId: userState.recieverId,
          receiverUser: userState.receiverUser,
          messages: userState.messages?.toList(),
          page: userState.page,
          pages: userState.pages,
          unreadCount: userState.unreadCount),
    );
  }

  Stream<ChatState> _mapRecievedSetWebinarChatToState(
      ReceivedSetChatWebinarResponse event) async* {
        final messages = event.response.payload?.messages?.toList();
        yield state.copyWith(messages:  messages);
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

  Stream<ChatState> _mapSendWebinarChatMessageToState(
      SendChatMessageStarted event) async* {
    final sendOrFail =
        await sendWebinarMessage(SendWebianrChatParams(message: event.message));
    yield sendOrFail.fold(
      (failure) => state.copyWith(error: failure),
      (r) =>
          // ignore: avoid_redundant_argument_values
          state.copyWith(error: null),
    );
  }

  Stream<ChatState> _mapSendWebinarChatReactionToState(
      SendChatReactionStarted event) async* {
    final sendOrFail =
        await sendWebinarMessage(SendWebianrChatParams(reactionId: event.reactionId));
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
          receiverUser: state.receiverUser!,
          page: state.page,
          pages: state.pages,
          messages: messages,
          unreadCount: state.unreadCount,
          error: state.error,
        );
      },
    );
  }

  Stream<ChatState> _mapReceivedWebinarMessageToState(
      ReceivedWebinarChatMessageResponse event) async* {
    final messages = [event.message, ...state.messages];
    yield state.copyWith(messages: messages);
  }
}
