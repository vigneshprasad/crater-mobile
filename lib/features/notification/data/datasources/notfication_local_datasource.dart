import 'package:hive/hive.dart';

import '../../../../constants/app_hive_boxes.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/page_api_response/page_api_response.dart';
import '../../domain/entity/notification_entity.dart';
import '../models/notification_model.dart';

abstract class NotificationLocalDatasource {
  PageApiResponse<Notification> getAllNotificationsFromCache();
  Future<void> persistAllNotificationToCache(List<Notification> notificaitons);
}

class NotificationLocalDatasourceImpl implements NotificationLocalDatasource {
  final Box<NotificationModel> _box =
      Hive.box<NotificationModel>(AppHiveBoxes.notificationsBox);
  @override
  PageApiResponse<Notification> getAllNotificationsFromCache() {
    if (_box.isEmpty || _box.values.length > 1) {
      throw CacheException("Box is empty");
    }

    final notifications = _box.values.toList();
    return PageApiResponse(
      fromCache: true,
      currentPage: 1,
      results: notifications,
      count: notifications.length,
    );
  }

  @override
  Future<void> persistAllNotificationToCache(
      List<Notification> notificaitons) async {
    final Map<String, NotificationModel> entries = notificaitons.fold(
      {},
      (previousValue, element) => {
        ...previousValue,
        element.pk.toString(): element as NotificationModel,
      },
    );
    try {
      await _box.putAll(entries);
    } catch (error) {
      throw CacheException(error);
    }
  }
}
