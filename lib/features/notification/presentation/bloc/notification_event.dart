part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class GetNotificationsRequestStarted extends NotificationEvent {
  final int page;
  final int pageSize;

  const GetNotificationsRequestStarted({
    @required this.page,
    @required this.pageSize,
  });

  @override
  List<Object> get props => [page, pageSize];
}
