part of 'notification_bloc.dart';

abstract class NotificationState extends Equatable {
  final List<MessageNotification> messageNotifcations;
  const NotificationState({this.messageNotifcations});
  @override
  List<Object> get props => [messageNotifcations];
}

class NotificationInitial extends NotificationState {
  const NotificationInitial() : super(messageNotifcations: const []);
}

class MessageNotificationLoaded extends NotificationState {
  final MessageNotification notification;

  const MessageNotificationLoaded({
    List<MessageNotification> messageNotifcations,
    this.notification,
  }) : super(messageNotifcations: messageNotifcations);
}
