import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/page_api_response/page_api_response.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../entity/notification_entity.dart';
import '../repository/notfication_repository.dart';

class UCGetNotificationPageRequest
    implements
        AsyncUseCase<PageApiResponse<Notification>, GetNotificationPageParams> {
  final NotificationRepository repository;

  UCGetNotificationPageRequest({required this.repository});

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
    required this.pageSize,
    required this.page,
  });

  @override
  List<Object> get props => [pageSize, page];
}
