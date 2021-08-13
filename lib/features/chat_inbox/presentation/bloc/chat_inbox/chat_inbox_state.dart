part of 'chat_inbox_bloc.dart';

abstract class ChatInboxState extends Equatable {
  final Object? error;
  final bool loading;

  const ChatInboxState({
    required this.error,
    required this.loading,
  });

  @override
  List<Object> get props => error != null ? [error!, loading] : [loading];
}

class ChatInboxInitial extends ChatInboxState {
  const ChatInboxInitial()
      : super(
          loading: false,
          error: null,
        );
}

class ChatInboxError extends ChatInboxState {
  const ChatInboxError({required dynamic error})
      : super(
          loading: false,
          error: error,
        );
}

class ChatInboxUsersRequestSent extends ChatInboxState {
  const ChatInboxUsersRequestSent()
      : super(
          loading: true,
          error: null,
        );
}

class ChatInboxUsersResponseReceived extends ChatInboxState {
  final List<ChatUser> users;
  final int page;
  final int pages;
  final bool fromCache;

  const ChatInboxUsersResponseReceived({
    required this.users,
    required this.page,
    required this.pages,
    required this.fromCache,
  }) : super(
          loading: false,
          error: null,
        );

  @override
  List<Object> get props => error != null
      ? [
          error!,
          loading,
          page,
          pages,
          fromCache,
          users,
        ]
      : [
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
    required this.user,
  }) : super(
          loading: false,
          error: null,
        );

  @override
  List<Object> get props =>
      error != null ? [error!, loading, user] : [loading, user];
}
