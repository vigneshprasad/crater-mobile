part of 'notification_bloc.dart';

@immutable
class NotificationState extends Equatable {
  final int count;
  final int currentPage;
  final int pages;
  final int pageSize;
  final List<Notification> notifications;
  final bool loading;
  final dynamic error;

  const NotificationState({
    this.count,
    this.currentPage,
    this.pages,
    this.pageSize,
    this.notifications,
    this.error,
    this.loading,
  });

  @override
  List<Object> get props => [
        count,
        currentPage,
        pages,
        pageSize,
        notifications,
        error,
        loading,
      ];

  NotificationState copyWith({
    int count,
    int currentPage,
    int pages,
    int pageSize,
    List<Notification> notifications,
    bool loading,
    dynamic error,
  }) {
    return NotificationState(
      count: count ?? this.count,
      currentPage: currentPage ?? this.currentPage,
      pages: pages ?? this.pages,
      pageSize: pageSize ?? this.pageSize,
      notifications: notifications ?? this.notifications,
      loading: loading ?? this.loading,
      error: error ?? this.error,
    );
  }
}

class NotificationInitial extends NotificationState {
  const NotificationInitial()
      : super(
          count: 0,
          currentPage: 1,
          pages: 1,
          pageSize: 10,
          notifications: const [],
          error: null,
          loading: false,
        );
}

class GetNotificationsReceived extends NotificationState {
  const GetNotificationsReceived({
    @required int count,
    @required int currentPage,
    @required int pages,
    @required List<Notification> results,
  }) : super(
          count: count,
          currentPage: currentPage,
          pages: pages,
          pageSize: 10,
          notifications: results,
          error: null,
          loading: false,
        );
}
