import 'package:flutter/material.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/features/websocket/domain/repository/websocket_repository.dart';
import '../models/requests.dart';

abstract class ChatRemoteDataSource {
  Future<void> sendSetChatWithUserRequest(String receiverId);
  Future<void> sendChatMessageToUser(String message);
  Future<void> sendReadUserMessages();
  Future<void> sendUserIsTyping();
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final WebSocketRepository repository;

  ChatRemoteDataSourceImpl({
    @required this.repository,
  });
  @override
  Future<void> sendSetChatWithUserRequest(String receiverId) async {
    final request = SetChatRequest(
      message: SetChatRequestParams(
        user: receiverId,
        page: 1,
      ),
    );
    final sendOrError = await repository.addMessageToSink(request.toJson());
    if (sendOrError.isLeft()) {
      throw WebsocketServerException();
    }
  }

  @override
  Future<void> sendChatMessageToUser(String message) async {
    final request = ChatMessageRequest(message: message);
    final sendOrError = await repository.addMessageToSink(request.toJson());
    if (sendOrError.isLeft()) {
      throw WebsocketServerException();
    }
  }

  @override
  Future<void> sendReadUserMessages() async {
    const request = ReadUserMessagesRequest();
    final sendOrError = await repository.addMessageToSink(request.toJson());
    if (sendOrError.isLeft()) {
      throw WebsocketServerException();
    }
  }

  @override
  Future<void> sendUserIsTyping() async {
    const request = UserTypingRequest();
    final sendOrError = await repository.addMessageToSink(request.toJson());
    if (sendOrError.isLeft()) {
      throw WebsocketServerException();
    }
  }
}
