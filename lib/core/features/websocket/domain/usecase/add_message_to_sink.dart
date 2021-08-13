import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../error/failures.dart';
import '../../../../usecase/aysnc_usecase.dart';
import '../repository/websocket_repository.dart';

class UCWebSocketAddToSink implements AsyncUseCase<void, Params> {
  final WebSocketRepository repository;

  UCWebSocketAddToSink({
    required this.repository,
  });

  @override
  Future<Either<Failure, void>> call(Params params) {
    return repository.addMessageToSink(params.message);
  }
}

class Params extends Equatable {
  final Map<String, dynamic> message;

  const Params({required this.message});

  @override
  List<Object> get props => [message];
}
