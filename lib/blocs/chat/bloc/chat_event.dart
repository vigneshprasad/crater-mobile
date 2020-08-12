part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();
}

class SetChatWithUser extends ChatEvent {
  final String recieverId;

  const SetChatWithUser({
    @required this.recieverId,
  });

  @override
  List<Object> get props => [recieverId];
}

class SetChatLoaded extends ChatEvent {
  final WSGetChatMessagesResponse response;

  const SetChatLoaded({
    this.response,
  });

  @override
  List<Object> get props => [response];
}

class SendUserIsTyping extends ChatEvent {
  const SendUserIsTyping();

  @override
  List<Object> get props => [];
}

class SendMessageToUser extends ChatEvent {
  final String message;

  const SendMessageToUser({
    this.message,
  });

  @override
  List<Object> get props => [message];
}
