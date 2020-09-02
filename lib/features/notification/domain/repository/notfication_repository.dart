import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/page_api_response/page_api_response.dart';
import '../entity/notification_entity.dart';

abstract class NotificationRepository {
  Future<Either<Failure, PageApiResponse<Notification>>> getNotificationsPage(
      int pageSize, int page);
}
