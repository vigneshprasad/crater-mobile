import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entity/chat_user_entity.dart';
import '../../domain/repository/chat_inbox_repository.dart';
import '../datasources/chat_inbox_local_datasource.dart';
import '../datasources/chat_inbox_remote_datasource.dart';

class ChatInboxRepositoryImpl implements ChatInboxRepository {
  final ChatInboxLocalDataSource localDataSource;
  final ChatInboxRemoteDataSource remoteDataSource;

  ChatInboxRepositoryImpl({
    @required this.localDataSource,
    @required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<ChatUser>>> getAllChatUsers(
    String search,
    String filter,
    int page,
    String latestMesssages,
  ) async {
    try {
      await remoteDataSource.sendGetAllUsersRequest(
        search,
        filter,
        page,
        latestMesssages,
      );
      return Right(localDataSource.getChatUsersFromCache(search));
    } on WebsocketServerException {
      return Left(WebsocketServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<ChatUser>>> receivedAllChatUsers(
    int page,
    int pages,
    List<ChatUser> users,
    dynamic errors,
  ) async {
    try {
      await localDataSource.persistChatUsers(users);
      return Right(localDataSource.getChatUsersFromCache(null));
    } on WebsocketServerException {
      return Left(WebsocketServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> sendStarChatUser({
    @required String user,
    @required bool isStarred,
  }) async {
    try {
      await remoteDataSource.sendStarUserRequest(
        user: user,
        isStarred: isStarred,
      );
      return const Right(null);
    } on WebsocketServerException {
      return Left(WebsocketServerFailure());
    }
  }

  @override
  Future<Either<Failure, ChatUser>> recievedUserChatStarChange(
      {bool isStarred, String user}) async {
    try {
      final updated = await localDataSource.updateUserStarredInCache(
          userId: user, isStarred: isStarred);
      return Right(updated);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
