part of 'chat_inbox_bloc.dart';

@immutable
class ChatInboxState extends Equatable {
  final String filter;
  final int page;
  final int pages;
  final List<ChatUser> users;
  final dynamic errors;
  final bool loading;

  const ChatInboxState({
    @required this.filter,
    @required this.page,
    @required this.pages,
    @required this.users,
    @required this.errors,
    @required this.loading,
  });

  @override
  List<Object> get props => [filter, page, pages, users, errors, loading];

  ChatInboxState copyWith({
    String filter,
    int page,
    int pages,
    List<ChatUser> users,
    dynamic errors,
    bool loading,
  }) {
    return ChatInboxState(
        filter: filter ?? this.filter,
        page: page ?? this.page,
        pages: pages ?? this.pages,
        users: users ?? this.users,
        errors: errors ?? this.errors,
        loading: loading ?? this.loading);
  }
}

class ChatInboxInitial extends ChatInboxState {
  const ChatInboxInitial()
      : super(
          filter: "all",
          page: 1,
          pages: 1,
          users: const [],
          loading: false,
          errors: null,
        );
}

class ChatInboxError extends ChatInboxState {
  const ChatInboxError()
      : super(
          filter: "all",
          page: 1,
          pages: 1,
          users: const [],
          loading: false,
          errors: true,
        );
}
