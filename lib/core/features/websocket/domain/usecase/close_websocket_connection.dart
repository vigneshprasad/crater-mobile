import 'package:dartz/dartz.dart';

import '../../../../error/failures.dart';
import '../../../../usecase/aysnc_usecase.dart';
import '../repository/websocket_repository.dart';

class UCWebSocketClose implements AsyncUseCase<void, NoParams> {
  final WebSocketRepository repository;

  UCWebSocketClose({
    required this.repository,
  });

  @override
  Future<Either<Failure, void>> call(NoParams params) {
    return repository.closeWebSocketConnection();
  }
}
