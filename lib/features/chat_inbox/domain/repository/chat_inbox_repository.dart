import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/failures.dart';
import '../entity/chat_user_entity.dart';

abstract class ChatInboxRepository {
  Future<Either<Failure, void>> sendStarChatUser({
    @required String user,
    @required bool isStarred,
  });
  Future<Either<Failure, List<ChatUser>>> receivedAllChatUsers(
    int page,
    int pages,
    List<ChatUser> users,
    dynamic errors,
  );
  Future<Either<Failure, List<ChatUser>>> getAllChatUsers(
    String search,
    String filter,
    int page,
    String latestMesssages,
  );
  Future<Either<Failure, ChatUser>> recievedUserChatStarChange({
    @required bool isStarred,
    @required String user,
  });
  Future<Either<Failure, void>> sendSearchAllChatUsers(
    String search,
    String filter,
    int page,
    String latestMesssages,
  );
}
