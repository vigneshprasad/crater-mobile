part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class OpenNotificationHiveStarted extends NotificationEvent {
  const OpenNotificationHiveStarted();
}

class UserNotificationLoaded extends NotificationEvent {
  final WSGetUserNotificatioResponse response;

  const UserNotificationLoaded({
    this.response,
  });

  @override
  List<Object> get props => [response];
}
