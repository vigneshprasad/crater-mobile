import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:worknetwork/core/config_reader/config_reader.dart';
import 'package:worknetwork/features/auth/presentation/screens/splash/splash_screen_state.dart';
import 'package:worknetwork/features/conversations/domain/entity/conversation_entity/conversation_entity.dart';

final userPermissionNotifierProvider =
    StateNotifierProvider<SocketIOManager, AsyncValue<UserPermission>>((ref) {
  return SocketIOManager(read: ref.read);
});

class SocketIOManager extends StateNotifier<AsyncValue<UserPermission>> {
  UserPermission? permission;
  Socket? streamSocket;
  Socket? permissionSocket;
  final Reader read;

  SocketIOManager({
    required this.read,
  }) : super(const AsyncValue<UserPermission>.loading());

  Future<void> listenPermissions() async {
    final token = read(authTokenProvider.notifier).state;
    if (token == null) {
      return;
    }
    final options =
        OptionBuilder().setTransports(['websocket']) // for Flutter or Dart VM
            // .disableAutoConnect() // disable auto-connection
            .setQuery({'token': token}).build();

    final baseUrl = ConfigReader.getWebSocketBaseUrl();
    final Socket socket = io(
      baseUrl,
      options,
    );

    socket.onConnect((data) {
      socket.emitWithAck(
        'user-permission:get',
        {},
        ack: updatePermissions,
      );
      debugPrint('socket connected $data');
    });

    socket.on('user-permission:updated', updatePermissions);

    socket.onDisconnect((_) => debugPrint('socket disconnected'));

    socket.onConnectError((error) {
      debugPrint('socket error $error');
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

  Future<void> onJoinStream(int groupId) async {
    final token = read(authTokenProvider.notifier).state;
    if (token == null) {
      return;
    }

    final options = OptionBuilder()
        .setTransports(['websocket']).setQuery({'token': token}).build();

    final baseUrl = ConfigReader.getWebSocketBaseUrl();
    final Socket socket = io(
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
      debugPrint('socket connected $data');
    });

    socket.on('chat:room-joined', updateViewCount);
    socket.on('chat:room-left', updateViewCount);

    socket.onDisconnect((_) => debugPrint('socket disconnected'));

    socket.onConnectError((error) {
      debugPrint('socket error $error');
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
    state = AsyncValue.data(permission);
  }

  void updateViewCount(dynamic data) {
    debugPrint(data.toString());
  }

  UserPermission? getPermissions() {
    return permission;
  }
}
