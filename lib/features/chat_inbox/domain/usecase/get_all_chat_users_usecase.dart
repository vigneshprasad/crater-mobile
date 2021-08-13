import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/page_socket_response/page_socket_response.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../entity/chat_user_entity.dart';
import '../repository/chat_inbox_repository.dart';

class UCGetAllChatUsers
    implements AsyncUseCase<PageSocketResponse<ChatUser>, GetAllUsersParams> {
  final ChatInboxRepository repository;

  UCGetAllChatUsers({
    required this.repository,
  });

  @override
  Future<Either<Failure, PageSocketResponse<ChatUser>>> call(
      GetAllUsersParams params) {
    return repository.getAllChatUsers(
      params.search,
      params.filter,
      params.page,
      params.latestMessage,
    );
  }
}

class GetAllUsersParams extends Equatable {
  final String search;
  final int page;
  final bool strict;
  final String filter;
  final String latestMessage;

  const GetAllUsersParams({
    this.latestMessage = '',
    this.search = "",
    this.page = 1,
    this.strict = true,
    this.filter = "all",
  });

  @override
  List<Object> get props => [
        search,
        page,
        strict,
        filter,
      ];
}
