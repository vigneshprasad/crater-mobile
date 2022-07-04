import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../error/failures.dart';
import '../../../../usecase/aysnc_usecase.dart';
import '../entity/websocket_connection.dart';
import '../repository/websocket_repository.dart';

class UCWebinarWebsocketConnect
    implements AsyncUseCase<WebSocketConnection, WebsocketConnectParams> {
  final WebSocketRepository repository;

  UCWebinarWebsocketConnect({required this.repository});

  @override
  Future<Either<Failure, WebSocketConnection>> call(WebsocketConnectParams params) {
    return repository.connectToWebinarWebsocketBackend(params.groupId);
  }
}

class WebsocketConnectParams extends Equatable {
  final String groupId;

  const WebsocketConnectParams({
    required this.groupId,
  });

  @override
  List<Object> get props => [groupId];
}
