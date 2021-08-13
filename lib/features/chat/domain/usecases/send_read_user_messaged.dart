import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../repository/chat_repository.dart';

class UCSendReadUserMessage implements AsyncUseCase<void, NoParams> {
  final ChatRepository repository;

  UCSendReadUserMessage({
    required this.repository,
  });

  @override
  Future<Either<Failure, void>> call(NoParams params) {
    return repository.sendReadUserMessages();
  }
}
