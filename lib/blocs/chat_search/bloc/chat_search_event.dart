part of 'chat_search_bloc.dart';

abstract class ChatSearchEvent extends Equatable {
  const ChatSearchEvent();

  @override
  List<Object> get props => [];
}

class ChatSearchResultsReceived extends ChatSearchEvent {
  final WSGetAllUsersResponse response;

  const ChatSearchResultsReceived({
    this.response,
  });

  @override
  List<Object> get props => [response];
}

class ChatSearchUsersStarted extends ChatSearchEvent {
  final AllUserRequestOptions options;

  const ChatSearchUsersStarted({
    this.options,
  });

  @override
  List<Object> get props => [options];
}
