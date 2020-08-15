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

class ChatUserNotificationLoaded extends InboxEvent {
  final MessageNotification notification;

  const ChatUserNotificationLoaded({this.notification});

  @override
  // TODO: implement props
  List<Object> get props => [notification];
}

class InboxGetAllUsersLoaded extends InboxEvent {
  final WSGetAllUsersResponse response;

  const InboxGetAllUsersLoaded({
    this.response,
  });

  @override
  List<Object> get props => [response];
}
