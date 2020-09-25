import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart' hide Notification;

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network_info/network_info.dart';
import '../../../../core/page_api_response/page_api_response.dart';
import '../../domain/entity/notification_entity.dart';
import '../../domain/repository/notfication_repository.dart';
import '../datasources/notfication_local_datasource.dart';
import '../datasources/notification_remote_datasource.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationLocalDatasource localDatasource;
  final NotificationRemotDatasource remotDatasource;
  final NetworkInfo networkInfo;

  NotificationRepositoryImpl({
    @required this.localDatasource,
    @required this.remotDatasource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, PageApiResponse<Notification>>> getNotificationsPage(
      int pageSize, int page) async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final data =
            await remotDatasource.getNotifcationsPageFromRemote(pageSize, page);
        await localDatasource.persistAllNotificationToCache(data.results);
        return Right(data);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final cached = localDatasource.getAllNotificationsFromCache();
        return Right(cached);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
