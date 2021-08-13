import 'package:dartz/dartz.dart';

import '../../../../error/failures.dart';
import '../../../../usecase/aysnc_usecase.dart';
import '../../../../usecase/sync_usecase.dart';
import '../entity/websocket_connection.dart';
import '../repository/websocket_repository.dart';

class UCWebSocketGetConnection
    implements SyncUseCase<WebSocketConnection, NoParams> {
  final WebSocketRepository repository;

  UCWebSocketGetConnection({required this.repository});

  @override
  Either<Failure, WebSocketConnection> call(NoParams params) {
    return repository.getWebSocketConnectionState();
  }
}
