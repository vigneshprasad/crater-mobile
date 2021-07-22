part of 'chat_inbox_bloc.dart';

abstract class ChatInboxEvent extends Equatable {
  const ChatInboxEvent();

  @override
  List<Object> get props => [];
}

class WebSocketOnline extends ChatInboxEvent {
  const WebSocketOnline();
  @override
  List<Object> get props => [];
}

class GetAllChatUsersRequest extends ChatInboxEvent {
  final String filter;
  final int page;
  final String search;

  const GetAllChatUsersRequest({
    required this.filter,
    required this.page,
    required this.search,
  });

  @override
  List<Object> get props => [
        filter,
        page,
        search,
      ];
}

class AllChatUsersReceived extends ChatInboxEvent {
  final GetAllUsersResponse response;

  const AllChatUsersReceived({
    required this.response,
  });

  @override
  List<Object> get props => [response];
}

class StarUserRequestStarted extends ChatInboxEvent {
  final String user;
  final bool isStarred;

  const StarUserRequestStarted({
    required this.user,
    required this.isStarred,
  });

  @override
  List<Object> get props => [user, isStarred];
}

class StarUserChangeRecieved extends ChatInboxEvent {
  final String user;
  final bool isStarred;

  const StarUserChangeRecieved({
    required this.user,
    required this.isStarred,
  });

  @override
  List<Object> get props => [user, isStarred];
}
