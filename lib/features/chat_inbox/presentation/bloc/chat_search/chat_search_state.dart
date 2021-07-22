part of 'chat_search_bloc.dart';

class ChatSearchState extends Equatable {
  final String search;
  final int page;
  final int pages;
  final List<ChatUser> results;
  final Object? error;

  const ChatSearchState({
    required this.search,
    this.error,
    required this.page,
    required this.pages,
    required this.results,
  });

  @override
  List<Object> get props => error != null
      ? [search, page, pages, results, error!]
      : [search, page, pages, results];

  ChatSearchState copyWith({
    String? search,
    int? page,
    int? pages,
    List<ChatUser>? results,
    dynamic error,
  }) {
    return ChatSearchState(
      search: search ?? this.search,
      page: page ?? this.page,
      pages: pages ?? this.pages,
      results: results ?? this.results,
      error: error ?? this.error,
    );
  }
}

class ChatSearchInitial extends ChatSearchState {
  const ChatSearchInitial()
      : super(
          search: "",
          page: 1,
          pages: 1,
          results: const [],
          error: null,
        );
}

class SocketConnectedInitState extends ChatSearchState {
  const SocketConnectedInitState()
      : super(
          search: "",
          page: 1,
          pages: 1,
          results: const [],
          error: null,
        );
}

class ChatSearchResultsLoaded extends ChatSearchState {
  const ChatSearchResultsLoaded({
    required String search,
    required int page,
    required int pages,
    required List<ChatUser> results,
    dynamic error,
  }) : super(
          search: search,
          page: page,
          pages: pages,
          results: results,
          error: error,
        );
}

class ChatResultsCacheLoaded extends ChatSearchState {
  const ChatResultsCacheLoaded({
    required String search,
    required int page,
    required int pages,
    required List<ChatUser> results,
    dynamic error,
  }) : super(
          search: search,
          page: page,
          pages: pages,
          results: results,
          error: error,
        );
}
