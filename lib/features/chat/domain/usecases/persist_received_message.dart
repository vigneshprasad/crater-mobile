import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../entity/chat_message_entity.dart';
import '../repository/chat_repository.dart';

class UCPersistReceivedMessage
    implements AsyncUseCase<ChatMessage, ReceivedMessageParams> {
  final ChatRepository repository;

  UCPersistReceivedMessage({@required this.repository});

  @override
  Future<Either<Failure, ChatMessage>> call(ReceivedMessageParams params) {
    return repository.persistRecievedChatMessage(
        params.message, params.chatKey);
  }
}

class ReceivedMessageParams extends Equatable {
  final ChatMessage message;
  final String chatKey;

  const ReceivedMessageParams({
    @required this.message,
    @required this.chatKey,
  });

  @override
  List<Object> get props => [message, chatKey];
}
