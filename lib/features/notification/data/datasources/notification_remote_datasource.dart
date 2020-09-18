import 'dart:convert';

import 'package:flutter/material.dart' hide Notification;
import 'package:worknetwork/core/error/exceptions.dart';
import 'package:worknetwork/features/notification/data/models/api_models.dart';

import '../../../../api/notifications/notifications_api_service.dart';
import '../../../../core/page_api_response/page_api_response.dart';
import '../../domain/entity/notification_entity.dart';

abstract class NotificationRemotDatasource {
  Future<PageApiResponse<Notification>> getNotifcationsPageFromRemote(
    int pageSize,
    int page,
  );
}

class NotificationRemotDatasourceImpl implements NotificationRemotDatasource {
  final NotificationApiService apiService;

  NotificationRemotDatasourceImpl({
    @required this.apiService,
  });

  @override
  Future<PageApiResponse<Notification>> getNotifcationsPageFromRemote(
      int pageSize, int page) async {
    final response = await apiService.getMyNotificationPage(pageSize, page);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.bodyString) as Map<String, dynamic>;
      final model = GetAllNotificationsPageResponse.fromJson(json);
      return PageApiResponse(
        count: model.count,
        pageSize: pageSize,
        currentPage: model.currentPage,
        fromCache: false,
        results: model.results,
      );
    } else {
      throw ServerException(response.error);
    }
  }
}
