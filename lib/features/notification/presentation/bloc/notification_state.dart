part of 'notification_bloc.dart';

@immutable
class NotificationState extends Equatable {
  final int? count;
  final int? currentPage;
  final int? pages;
  final int? pageSize;
  final List<Notification>? notifications;
  final bool loading;
  final Object? error;

  const NotificationState({
    this.count,
    this.currentPage,
    this.pages,
    this.pageSize,
    this.notifications,
    this.error,
    required this.loading,
  });

  @override
  List<Object> get props {
    final List<Object> temp = [
      loading,
    ];
    if (pages != null) temp.add(pages!);
    if (count != null) temp.add(count!);
    if (currentPage != null) temp.add(currentPage!);
    if (notifications != null) temp.add(notifications!);
    if (pageSize != null) temp.add(pageSize!);
    if (error != null) temp.add(error!);
    return temp;
  }

  NotificationState copyWith({
    int? count,
    int? currentPage,
    int? pages,
    int? pageSize,
    List<Notification>? notifications,
    bool? loading,
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
    int? count,
    int? currentPage,
    int? pages,
    List<Notification>? results,
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
