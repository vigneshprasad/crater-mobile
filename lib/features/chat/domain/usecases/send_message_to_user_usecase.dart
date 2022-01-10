import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../repository/chat_repository.dart';

class UCSendChatToUser implements AsyncUseCase<void, SendChatParams> {
  final ChatRepository repository;

  UCSendChatToUser({
    required this.repository,
  });

  @override
  Future<Either<Failure, void>> call(SendChatParams params) {
    return repository.sendChatMessageToUser(params.message);
  }
}

class SendChatParams extends Equatable {
  final String message;

  const SendChatParams({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
