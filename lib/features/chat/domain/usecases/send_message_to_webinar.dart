import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../repository/chat_repository.dart';

class UCSendChatToWebinar implements AsyncUseCase<void, SendWebianrChatParams> {
  final ChatRepository repository;

  UCSendChatToWebinar({
    required this.repository,
  });

  @override
  Future<Either<Failure, void>> call(SendWebianrChatParams params) {
    if (params.reactionId == null) {
      return repository.sendChatMessageToWebinar(params.message ?? '');
    }

    return repository.sendChatReactionToWebinar(params.reactionId ?? '');
  }
}

class SendWebianrChatParams extends Equatable {
  final String? message;
  final String? reactionId;

  const SendWebianrChatParams({
     this.message,
     this.reactionId,
  });

  @override
  List<Object> get props => [message ?? ''];
}
