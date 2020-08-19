import 'dart:async';

import 'package:kiwi/kiwi.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../constants/app_constants.dart';
import '../../../features/auth/data/datasources/auth_local_datasource.dart';

class WebSocketRepository {
  WebSocketChannel channel;
  final StreamController streamController = StreamController.broadcast();

  Future<void> initSocket() async {
    final user =
        KiwiContainer().resolve<AuthLocalDataSource>().getUserFromCache();
    final token = user.token;
    if (user == null) {
      throw Exception('User Token is missing');
    }

    channel = IOWebSocketChannel.connect(
      "${AppConstants.websocketBaseUrl}/$token/",
    );
    streamController.addStream(channel.stream);
  }
}
