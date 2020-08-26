import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:worknetwork/core/error/exceptions.dart';
import 'package:worknetwork/features/auth/domain/repository/auth_repository.dart';

import '../../../../error/failures.dart';
import '../../domain/entity/websocket_connection.dart';
import '../../domain/repository/websocket_repository.dart';
import '../datasources/weboscket_local_datasource.dart';
import '../datasources/weboscket_remote_datasource.dart';

class WebsocketRepositoryImpl implements WebSocketRepository {
  final WebSocketLocalDataSource localDataSource;
  final WebSocketRemoteDataSource remoteDataSource;
  final AuthRepository authRepository;

  WebsocketRepositoryImpl({
    @required this.localDataSource,
    @required this.remoteDataSource,
    @required this.authRepository,
  });

  @override
  Future<Either<Failure, WebSocketConnection>>
      connectToWebsocketBackend() async {
    final userOrError = await authRepository.getPersistedUser();
    return userOrError.fold(
      (failure) => throw WebsocketServerFailure("User not in storage"),
      (user) async {
        try {
          localDataSource.channel ??=
              await remoteDataSource.connectToWebsocketBackend(user.token);
          localDataSource.streamcontroller
              .addStream(localDataSource.channel.stream);
          return Right(WebSocketConnection(
            channel: localDataSource.channel,
            streamController: localDataSource.streamcontroller,
          ));
        } on WebsocketServerException {
          return Left(WebsocketServerFailure());
        }
      },
    );
  }

  @override
  Either<Failure, WebSocketConnection> getWebSocketConnectionState() {
    if (localDataSource.channel == null) {
      return Left(WebsocketLocalFailure());
    }
    return Right(WebSocketConnection(
        channel: localDataSource.channel,
        streamController: localDataSource.streamcontroller));
  }

  @override
  Future<Either<Failure, void>> closeWebSocketConnection() async {
    try {
      await localDataSource.closeConnection();
      return const Right(null);
    } on WebSocketCloseException {
      return Left(WebsocketCloseFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addMessageToSink(
      Map<String, dynamic> message) async {
    final data = jsonEncode(message);
    var channel = localDataSource.channel;
    if (channel == null) {
      final stateOrError = await connectToWebsocketBackend();
      stateOrError.fold(
        (failure) => Left(failure),
        (connection) {
          channel = connection.channel;
        },
      );
    }
    channel.sink.add(data);
    return const Right(null);
  }
}
