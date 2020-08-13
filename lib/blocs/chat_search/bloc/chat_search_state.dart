part of 'chat_search_bloc.dart';

abstract class ChatSearchState extends Equatable {
  const ChatSearchState();

  @override
  List<Object> get props => [];
}

class ChatSearchInitial extends ChatSearchState {}

class ChatSearchResultsLoaded extends ChatSearchState {
  final List<ChatUser> users;

  const ChatSearchResultsLoaded({
    this.users,
  });

  @override
  List<Object> get props => [users];
}

class ChatSearchListening extends ChatSearchState {}
