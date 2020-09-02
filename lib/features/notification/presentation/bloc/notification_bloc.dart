import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' hide Notification;

import '../../domain/entity/notification_entity.dart';
import '../../domain/usecases/get_notifications_page_usecase.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final UCGetNotificationPageRequest getNotifications;
  NotificationBloc({
    @required this.getNotifications,
  }) : super(const NotificationInitial());

  @override
  Stream<NotificationState> mapEventToState(
    NotificationEvent event,
  ) async* {
    if (event is GetNotificationsRequestStarted) {
      yield* _mapGetNotificationsRequestToState(event);
    }
  }

  Stream<NotificationState> _mapGetNotificationsRequestToState(
      GetNotificationsRequestStarted event) async* {
    yield state.copyWith(loading: true);
    final dataOrError = await getNotifications(
        GetNotificationPageParams(page: event.page, pageSize: event.pageSize));
    yield dataOrError.fold(
      (failure) => state.copyWith(error: failure, loading: false),
      (results) => GetNotificationsReceived(
        count: results.count,
        currentPage: results.currentPage,
        results: results.results,
        pages: results.pages,
      ),
    );
  }
}
