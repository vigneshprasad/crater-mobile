import 'dart:async';

import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/features/websocket/domain/repository/websocket_repository.dart';
import '../../../chat_inbox/domain/entity/chat_user_entity.dart';
import '../../domain/entity/chat_message_entity.dart';
import '../../domain/entity/user_chat_entity.dart';
import '../../domain/repository/chat_repository.dart';
import '../datasources/chat_local_datasource.dart';
import '../datasources/chat_remote_datasource.dart';

class ChatRepositoryImpl implements ChatRepository {
  final WebSocketRepository repository;
  final ChatLocalDataSource localDataSource;
  final ChatRemoteDataSource remoteDataSource;

  ChatRepositoryImpl({
    required this.repository,
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, void>> sendChatMessageToUser(String message) async {
    try {
      await remoteDataSource.sendChatMessageToUser(message);
      return const Right(null);
    } on WebsocketServerException {
      return Left(WebsocketServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> sendChatMessageToWebinar(String message) async {
    try {
      await remoteDataSource.sendChatMessageToWebinar(message);
      return const Right(null);
    } on WebsocketServerException {
      return Left(WebsocketServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> sendChatReactionToWebinar(String reactionId) async {
    try {
      await remoteDataSource.sendChatReactionToWebinar(reactionId);
      return const Right(null);
    } on WebsocketServerException {
      return Left(WebsocketServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> sendReadUserMessages() async {
    try {
      await remoteDataSource.sendReadUserMessages();
      return const Right(null);
    } on WebsocketServerException {
      return Left(WebsocketServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> sendUserIsTyping() async {
    try {
      await remoteDataSource.sendUserIsTyping();
      return const Right(null);
    } on WebsocketServerException {
      return Left(WebsocketServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserChat>> setChatWithUser(String receiverId) async {
    try {
      await remoteDataSource.sendSetChatWithUserRequest(receiverId);
      return Right(localDataSource.getUserChatFromCache(receiverId));
    } on WebsocketServerException {
      return Left(WebsocketServerFailure());
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Either<Failure, Stream> getChatSocketStream() {
    final connectionOrError = repository.getWebSocketConnectionState();
    return connectionOrError.fold(
      (failure) => Left(WebsocketLocalFailure()),
      (connection) => Right(connection.streamController.stream),
    );
  }

  @override
  Future<Either<Failure, UserChat>> recievedSetChatUser(
    List<ChatMessage> messages,
    ChatUser receiverUser,
    int page,
    int pages,
    int unreadCount,
  ) async {
    try {
      final response = await localDataSource.persistUserChat(
        messages,
        receiverUser,
        page,
        pages,
        unreadCount,
      );
      return Right(response);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, ChatMessage>> persistRecievedChatMessage(
    ChatMessage message,
    String chatKey,
  ) async {
    try {
      final cached = await localDataSource.persistChatMessage(message, chatKey);
      return Right(cached);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
