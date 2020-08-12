part of 'userchat_bloc.dart';

abstract class UserchatState extends Equatable {
  final ChatUser receiverUser;
  final List<ChatMessage> messages;
  final int pages;
  final int page;

  const UserchatState({
    this.receiverUser,
    this.messages,
    this.pages,
    this.page,
  });
}

class UserchatInitial extends UserchatState {
  const UserchatInitial()
      : super(
          receiverUser: null,
          messages: const [],
          pages: 1,
          page: 1,
        );

  @override
  List<Object> get props => [receiverUser, messages, pages, page];
}
