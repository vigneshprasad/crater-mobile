part of 'inbox_bloc.dart';

abstract class InboxEvent extends Equatable {
  const InboxEvent();
}

class InboxGetAllUsers extends InboxEvent {
  final WSAllUsersRequest request;

  const InboxGetAllUsers({
    @required this.request,
  });

  @override
  List<Object> get props => [request];
}

class InboxGetAllUsersLoaded extends InboxEvent {
  final WSGetAllUsersResponse response;

  const InboxGetAllUsersLoaded({
    this.response,
  });

  @override
  List<Object> get props => [response];
}
