import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../repository/chat_inbox_repository.dart';

class UCSendStarChatUser implements AsyncUseCase<void, SendStarChatUserParams> {
  final ChatInboxRepository repository;

  UCSendStarChatUser({
    required this.repository,
  });

  @override
  Future<Either<Failure, void>> call(SendStarChatUserParams params) {
    return repository.sendStarChatUser(
        user: params.user, isStarred: params.isStarred);
  }
}

class SendStarChatUserParams extends Equatable {
  final String user;
  final bool isStarred;

  const SendStarChatUserParams({
    required this.user,
    required this.isStarred,
  });

  @override
  List<Object> get props => [user];
}
