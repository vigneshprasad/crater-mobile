import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:worknetwork/core/error/failures.dart';
import 'package:worknetwork/features/notification/domain/repository/notfication_repository.dart';

import '../../../../core/page_api_response/page_api_response.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../entity/notification_entity.dart';

class UCGetNotificationPageRequest
    implements
        AsyncUseCase<PageApiResponse<Notification>, GetNotificationPageParams> {
  final NotificationRepository repository;

  UCGetNotificationPageRequest({@required this.repository});

  @override
  Future<Either<Failure, PageApiResponse<Notification>>> call(
      GetNotificationPageParams params) {
    return repository.getNotificationsPage(params.pageSize, params.page);
  }
}

class GetNotificationPageParams extends Equatable {
  final int pageSize;
  final int page;

  const GetNotificationPageParams({
    this.pageSize,
    this.page,
  });

  @override
  List<Object> get props => [pageSize, page];
}
