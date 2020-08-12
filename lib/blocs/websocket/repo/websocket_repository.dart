import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:worknetwork/constants/app_constants.dart';
import 'package:worknetwork/constants/shared_pref_keys.dart';

class WebSocketRepository {
  WebSocketChannel channel;
  final StreamController streamController = StreamController.broadcast();

  Future<void> initSocket() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final hasToken = prefs.containsKey(SharedPrefKeys.authToken);
    if (!hasToken) {
      throw Exception('User Token is missing');
    }

    final token = prefs.getString(SharedPrefKeys.authToken);

    channel = IOWebSocketChannel.connect(
      "${AppConstants.websocketBaseUrl}/$token/",
    );
    streamController.addStream(channel.stream);
  }
}
