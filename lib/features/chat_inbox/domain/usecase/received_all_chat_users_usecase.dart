import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../entity/chat_user_entity.dart';
import '../repository/chat_inbox_repository.dart';

class UCRecievedAllChatUsers
    implements AsyncUseCase<List<ChatUser>, RecievedAllUsersParams> {
  final ChatInboxRepository repository;

  UCRecievedAllChatUsers({
    @required this.repository,
  });

  @override
  Future<Either<Failure, List<ChatUser>>> call(RecievedAllUsersParams params) {
    return repository.receivedAllChatUsers(
      params.page,
      params.pages,
      params.users,
      params.errors,
    );
  }
}

class RecievedAllUsersParams extends Equatable {
  final int page;
  final int pages;
  final List<ChatUser> users;
  final dynamic errors;

  const RecievedAllUsersParams({
    @required this.page,
    @required this.pages,
    @required this.users,
    @required this.errors,
  });

  @override
  List<Object> get props => [
        page,
        pages,
        users,
        errors,
      ];
}
