import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../../../../core/usecase/sync_usecase.dart';
import '../repository/chat_repository.dart';

class UCGetChatSocketStream implements SyncUseCase<Stream<dynamic>, NoParams> {
  final ChatRepository repository;

  UCGetChatSocketStream({
    @required this.repository,
  });

  @override
  Either<Failure, Stream<dynamic>> call(NoParams params) {
    return repository.getChatSocketStream();
  }
}
