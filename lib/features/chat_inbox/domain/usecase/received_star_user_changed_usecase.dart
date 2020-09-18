import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../entity/chat_user_entity.dart';
import '../repository/chat_inbox_repository.dart';

class UCReceivedStarUserChanged
    implements AsyncUseCase<ChatUser, ReceivedStarUserParams> {
  final ChatInboxRepository repository;

  UCReceivedStarUserChanged({
    @required this.repository,
  });

  @override
  Future<Either<Failure, ChatUser>> call(ReceivedStarUserParams params) {
    return repository.recievedUserChatStarChange(
      isStarred: params.isStarred,
      user: params.user,
    );
  }
}

class ReceivedStarUserParams extends Equatable {
  final String user;
  final bool isStarred;

  const ReceivedStarUserParams({
    this.user,
    this.isStarred,
  });

  @override
  List<Object> get props => [user, isStarred];
}
