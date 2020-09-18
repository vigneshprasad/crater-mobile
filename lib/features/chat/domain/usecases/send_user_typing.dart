import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../repository/chat_repository.dart';

class UCSendUserIsTyping implements AsyncUseCase<void, NoParams> {
  final ChatRepository repository;

  UCSendUserIsTyping({
    @required this.repository,
  });

  @override
  Future<Either<Failure, void>> call(NoParams params) {
    return repository.sendUserIsTyping();
  }
}
