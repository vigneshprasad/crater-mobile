part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  final ChatUser recieverUser;
  final List<ChatMessage> messages;
  final int page;
  final int pages;

  const ChatState({
    this.recieverUser,
    this.messages,
    this.page,
    this.pages,
  });
}

class ChatInitial extends ChatState {
  const ChatInitial()
      : super(
          messages: const [],
          page: 1,
          pages: 1,
        );
  @override
  List<Object> get props => [];
}

class SetChatUpdated extends ChatState {
  const SetChatUpdated({
    @required ChatUser recieverUser,
    @required List<ChatMessage> messages,
    @required int page,
    @required int pages,
  }) : super(
          messages: messages,
          page: page,
          pages: pages,
          recieverUser: recieverUser,
        );

  @override
  List<Object> get props => [recieverUser, messages, page, pages];
}
