import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/page_socket_response/page_socket_response.dart';
import '../../domain/entity/chat_user_entity.dart';
import '../../domain/repository/chat_inbox_repository.dart';
import '../datasources/chat_inbox_local_datasource.dart';
import '../datasources/chat_inbox_remote_datasource.dart';

class ChatInboxRepositoryImpl implements ChatInboxRepository {
  final ChatInboxLocalDataSource localDataSource;
  final ChatInboxRemoteDataSource remoteDataSource;

  ChatInboxRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, PageSocketResponse<ChatUser>>> getAllChatUsers(
    String search,
    String filter,
    int page,
    String latestMesssages,
  ) async {
    try {
      await remoteDataSource.sendGetAllUsersRequest(
        search: search,
        filter: filter,
        page: page,
        latestMessages: latestMesssages,
      );
      final cached = localDataSource.getChatUsersFromCache(search);
      return Right(PageSocketResponse<ChatUser>(
        fromCache: true,
        page: 1,
        pages: 1,
        results: cached,
      ));
    } on WebsocketServerException {
      return Left(WebsocketServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> persistChatUsers(List<ChatUser> users) async {
    try {
      await localDataSource.persistChatUsers(users);
      return const Right(null);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> sendStarChatUser({
    required String user,
    required bool isStarred,
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
      {required bool isStarred, required String user}) async {
    try {
      final updated = await localDataSource.updateUserStarredInCache(
          userId: user, isStarred: isStarred);
      return Right(updated);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> sendSearchAllChatUsers(
      String search, String filter, int page, String latestMesssages) async {
    try {
      await remoteDataSource.sendGetAllUsersRequest(
        search: search,
        filter: filter,
        page: page,
        latestMessages: latestMesssages,
      );
      return const Right(null);
    } on WebsocketServerException {
      return Left(WebsocketServerFailure());
    }
  }
}
