part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class WebSocketBlocConnected extends ChatEvent {
  const WebSocketBlocConnected();
}

class SetChatWithUserStarted extends ChatEvent {
  final String recieverId;

  const SetChatWithUserStarted({
    required this.recieverId,
  });

  @override
  List<Object> get props => [recieverId];
}

class SendUserIsTypingRequest extends ChatEvent {
  const SendUserIsTypingRequest();
}

class ReceivedSetChatUserResponse extends ChatEvent {
  final SetChatUserResponse response;

  const ReceivedSetChatUserResponse({
    required this.response,
  });

  @override
  List<Object> get props => [response];
}

class ReceivedSetChatWebinarResponse extends ChatEvent {
  final SetChatWebinarResponse response;

  const ReceivedSetChatWebinarResponse({
    required this.response,
  });

  @override
  List<Object> get props => [response];
}

class SendChatMessageStarted extends ChatEvent {
  final String message;

  const SendChatMessageStarted({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class SendChatReactionStarted extends ChatEvent {
  final String reactionId;

  const SendChatReactionStarted({
    required this.reactionId,
  });

  @override
  List<Object> get props => [reactionId];
}

class ReceivedChatMessageResponse extends ChatEvent {
  final String chatKey;
  final ChatMessage message;

  const ReceivedChatMessageResponse({
    required this.chatKey,
    required this.message,
  });
}

class ReceivedWebinarChatMessageResponse extends ChatEvent {
  final ChatMessage message;

  const ReceivedWebinarChatMessageResponse({
    required this.message,
  });
}

class SendReadChatMessagesRequest extends ChatEvent {
  const SendReadChatMessagesRequest();
}
