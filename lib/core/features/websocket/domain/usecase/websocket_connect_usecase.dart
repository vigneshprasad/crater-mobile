import 'package:dartz/dartz.dart';

import '../../../../error/failures.dart';
import '../../../../usecase/aysnc_usecase.dart';
import '../entity/websocket_connection.dart';
import '../repository/websocket_repository.dart';

class UCWebsocketConnect
    implements AsyncUseCase<WebSocketConnection, NoParams> {
  final WebSocketRepository repository;

  UCWebsocketConnect({required this.repository});

  @override
  Future<Either<Failure, WebSocketConnection>> call(NoParams params) {
    return repository.connectToWebsocketBackend();
  }
}
