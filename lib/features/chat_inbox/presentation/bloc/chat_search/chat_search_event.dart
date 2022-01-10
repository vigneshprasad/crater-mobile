part of 'chat_search_bloc.dart';

abstract class ChatSearchEvent extends Equatable {
  const ChatSearchEvent();

  @override
  List<Object> get props => [];
}

class SendSearchUsersRequestStarted extends ChatSearchEvent {
  final String search;
  final int page;
  final bool? strict;
  final String? filter;

  const SendSearchUsersRequestStarted({
    required this.search,
    required this.page,
    this.strict,
    this.filter,
  });

  @override
  List<Object> get props {
    final List<Object> temp = [search, page];

    if (filter != null) {
      temp.add(filter!);
    }

    if (strict != null) {
      temp.add(strict!);
    }
    return temp;
  }
}

class WebSocketBlocConnected extends ChatSearchEvent {
  const WebSocketBlocConnected();
}

class SearchResultsReceived extends ChatSearchEvent {
  final GetSearchAllUsersResponse response;

  const SearchResultsReceived({
    required this.response,
  });

  @override
  List<Object> get props => [response];
}
