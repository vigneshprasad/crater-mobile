import 'package:flutter/material.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/features/websocket/domain/repository/websocket_repository.dart';
import '../models/requests.dart';

abstract class ChatInboxRemoteDataSource {
  Future<void> sendGetAllUsersRequest([
    String search,
    String filter,
    int page,
    String latestMessages,
  ]);
  Future<void> sendStarUserRequest({
    @required String user,
    @required bool isStarred,
  });
}

class ChatInboxRemoteDataSourceImpl implements ChatInboxRemoteDataSource {
  final WebSocketRepository webSocketRepository;

  ChatInboxRemoteDataSourceImpl({
    @required this.webSocketRepository,
  });

  @override
  Future<void> sendGetAllUsersRequest([
    String search,
    String filter,
    int page,
    String latestMessages,
  ]) async {
    final request = GetAllChatUsersRequest(
        message: GetAllUsersRequestParams(
      search: search,
      filter: filter,
      page: page,
      latestMessages: latestMessages,
    ));
    final sendOrError =
        await webSocketRepository.addMessageToSink(request.toJson());
    if (sendOrError.isLeft()) {
      throw WebsocketServerException();
    }
  }

  @override
  Future<void> sendStarUserRequest({
    @required String user,
    @required bool isStarred,
  }) async {
    Map<String, dynamic> data;
    if (isStarred) {
      final request = StarChatUserRequest(
        message: StarChatUserRequestParams(user: user),
      );
      data = request.toJson();
    } else {
      final request = UnStarChatUserRequest(
        message: StarChatUserRequestParams(user: user),
      );
      data = request.toJson();
    }

    final sendOrError = await webSocketRepository.addMessageToSink(data);
    if (sendOrError.isLeft()) {
      throw WebsocketServerException();
    }
  }
}
