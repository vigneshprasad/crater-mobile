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
    this.recieverId,
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
    @required this.response,
  });

  @override
  List<Object> get props => [response];
}

class SendChatMessageStarted extends ChatEvent {
  final String message;

  const SendChatMessageStarted({
    this.message,
  });

  @override
  List<Object> get props => [message];
}

class ReceivedChatMessageResponse extends ChatEvent {
  final String chatKey;
  final ChatMessage message;

  const ReceivedChatMessageResponse({
    @required this.chatKey,
    @required this.message,
  });
}
