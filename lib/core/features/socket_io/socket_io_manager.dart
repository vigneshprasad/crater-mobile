import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kiwi/kiwi.dart';
import 'package:worknetwork/core/config_reader/config_reader.dart';
import 'package:worknetwork/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:worknetwork/features/conversations/domain/entity/conversation_entity/conversation_entity.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

final userPermissionNotifierProvider =
    StateNotifierProvider<SocketIOManager, AsyncValue<UserPermission>>((ref) {
  return SocketIOManager();
});

class SocketIOManager extends StateNotifier<AsyncValue<UserPermission>> {
  UserPermission? permission;
  IO.Socket? streamSocket;
  IO.Socket? permissionSocket;

  SocketIOManager() : super(const AsyncValue<UserPermission>.loading());

  String? getToken() {
    try {
      final user =
          KiwiContainer().resolve<AuthLocalDataSource>().getUserFromCache();
      return user.token;
    } catch (exception) {
      debugPrint(exception.toString());
      return null;
    }
  }

  @override
  Future<void> listenPermissions() async {
    final token = getToken();
    if (token == null) {
      return;
    }
    final options = IO.OptionBuilder()
        .setTransports(['websocket']) // for Flutter or Dart VM
        // .disableAutoConnect() // disable auto-connection
        .setQuery({'token': token}).build();

    final baseUrl = ConfigReader.getWebSocketBaseUrl();
    final IO.Socket socket = IO.io(
      baseUrl,
      options,
    );

    socket.onConnect((data) {
      socket.emitWithAck(
        'user-permission:get',
        {},
        ack: updatePermissions,
      );
      debugPrint('socket connected ' + data.toString());
    });

    socket.on('user-permission:updated', updatePermissions);

    socket.onDisconnect((_) => debugPrint('socket disconnected'));

    socket.onConnectError((error) {
      debugPrint('socket error ' + error.toString());
    });

    permissionSocket = socket;
    // socket.connect();
  }

  void onLogout() {
    permissionSocket?.disconnect();
    streamSocket?.disconnect();
    permissionSocket = null;
    streamSocket = null;
  }

  @override
  Future<void> onJoinStream(int groupId) async {
    final token = getToken();
    if (token == null) {
      return;
    }

    final options = IO.OptionBuilder()
        .setTransports(['websocket']).setQuery({'token': token}).build();

    final baseUrl = ConfigReader.getWebSocketBaseUrl();
    final IO.Socket socket = IO.io(
      '$baseUrl/chat',
      options,
    );

    socket.onConnect((data) {
      socket.emitWithAck(
        'chat:join-room',
        {
          'group': groupId.toString(),
        },
        ack: updateViewCount,
      );
      debugPrint('socket connected ' + data.toString());
    });

    socket.on('chat:room-joined', updateViewCount);
    socket.on('chat:room-left', updateViewCount);

    socket.onDisconnect((_) => debugPrint('socket disconnected'));

    socket.onConnectError((error) {
      debugPrint('socket error ' + error.toString());
    });

    streamSocket = socket;
  }

  void onLeaveStream() {
    streamSocket?.disconnect();
    streamSocket = null;
  }

  void updatePermissions(dynamic data) {
    final json = data as Map<String, dynamic>?;
    if (json == null) {
      return;
    }
    final permission = UserPermission.fromJson(json);
    this.permission = permission;
    if (permission != null) {
      state = AsyncValue.data(permission);
    }
  }

  void updateViewCount(dynamic data) {
    debugPrint(data.toString());
  }

  @override
  UserPermission? getPermissions() {
    return permission;
  }
}
