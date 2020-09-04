part of 'chat_inbox_bloc.dart';

abstract class ChatInboxState extends Equatable {
  final dynamic error;
  final bool loading;

  const ChatInboxState({
    @required this.error,
    @required this.loading,
  });

  @override
  List<Object> get props => [error, loading];
}

class ChatInboxInitial extends ChatInboxState {
  const ChatInboxInitial()
      : super(
          loading: false,
          error: null,
        );
}

class ChatInboxError extends ChatInboxState {
  const ChatInboxError({@required dynamic error})
      : super(
          loading: false,
          error: error,
        );
}

class ChatInboxUsersResponseReceived extends ChatInboxState {
  final List<ChatUser> users;
  final int page;
  final int pages;
  final bool fromCache;

  const ChatInboxUsersResponseReceived({
    @required this.users,
    @required this.page,
    @required this.pages,
    @required this.fromCache,
  }) : super(
          loading: false,
          error: null,
        );

  @override
  List<Object> get props => [
        error,
        loading,
        page,
        pages,
        fromCache,
        users,
      ];
}

class ChatInboxStarChangeReceived extends ChatInboxState {
  final ChatUser user;

  const ChatInboxStarChangeReceived({
    this.user,
  }) : super(
          loading: false,
          error: null,
        );

  @override
  List<Object> get props => [error, loading, user];
}
