import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:worknetwork/features/chat/domain/entity/user_chat_entity.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../repository/chat_repository.dart';

class UCSetChatWithUser implements AsyncUseCase<UserChat, SetChatParams> {
  final ChatRepository repository;

  UCSetChatWithUser({
    @required this.repository,
  });

  @override
  Future<Either<Failure, UserChat>> call(SetChatParams params) {
    return repository.setChatWithUser(params.receiverId);
  }
}

class SetChatParams extends Equatable {
  final String receiverId;

  const SetChatParams({
    @required this.receiverId,
  });

  @override
  List<Object> get props => [receiverId];
}
