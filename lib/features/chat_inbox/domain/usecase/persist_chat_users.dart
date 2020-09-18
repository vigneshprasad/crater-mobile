import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../entity/chat_user_entity.dart';
import '../repository/chat_inbox_repository.dart';

class UCPersistChatUsers
    implements AsyncUseCase<void, PersistChatUsersParaams> {
  final ChatInboxRepository repository;

  UCPersistChatUsers(this.repository);

  @override
  Future<Either<Failure, void>> call(PersistChatUsersParaams params) {
    return repository.persistChatUsers(params.users);
  }
}

class PersistChatUsersParaams extends Equatable {
  final List<ChatUser> users;

  const PersistChatUsersParaams({
    @required this.users,
  });

  @override
  List<Object> get props => [users];
}
