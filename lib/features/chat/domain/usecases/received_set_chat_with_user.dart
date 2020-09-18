import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../../../chat_inbox/domain/entity/chat_user_entity.dart';
import '../entity/chat_message_entity.dart';
import '../entity/user_chat_entity.dart';
import '../repository/chat_repository.dart';

class UCReceivedSetChatWithUser
    implements AsyncUseCase<UserChat, ReceivedSetChatParams> {
  final ChatRepository repository;

  UCReceivedSetChatWithUser({
    @required this.repository,
  });

  @override
  Future<Either<Failure, UserChat>> call(ReceivedSetChatParams params) {
    return repository.recievedSetChatUser(
      params.messages,
      params.receiverUser,
      params.page,
      params.pages,
      params.unreadCount,
    );
  }
}

class ReceivedSetChatParams extends Equatable {
  final List<ChatMessage> messages;
  final ChatUser receiverUser;
  final int page;
  final int pages;
  final int unreadCount;

  const ReceivedSetChatParams({
    this.messages,
    this.receiverUser,
    this.page,
    this.pages,
    this.unreadCount,
  });

  @override
  List<Object> get props => [
        messages,
        receiverUser,
        page,
        pages,
        unreadCount,
      ];
}
