import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kiwi/kiwi.dart';
import 'package:worknetwork/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:worknetwork/features/conversations/domain/entity/conversation_entity/conversation_entity.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

final userPermissionNotifierProvider =
    StateNotifierProvider<SocketIOManager, AsyncValue<UserPermission>>((ref) {
  return SocketIOManager();
});

class SocketIOManager extends StateNotifier<AsyncValue<UserPermission>> {
  UserPermission? permission;

  SocketIOManager() : super(const AsyncValue<UserPermission>.loading());

  @override
  Future<void> listenPermissions() async {
    final user =
        KiwiContainer().resolve<AuthLocalDataSource>().getUserFromCache();
    final token = user.token;
    if (token == null) {
      return;
    }

    final options = IO.OptionBuilder()
        .setTransports(['websocket']) // for Flutter or Dart VM
        // .disableAutoConnect() // disable auto-connection
        .setQuery({'token': token}).build();

    final IO.Socket socket = IO.io(
      'https://socket-dev.worknetwork.in',
      options,
    );

    socket.onConnect((data) {
      socket.emitWithAck(
        'user-permission:get',
        {},
        ack: updatePermissions,
      );
      print('socket connected ' + data.toString());
    });

    socket.on('user-permission:updated', updatePermissions);

    socket.onDisconnect((_) => print('socket disconnected'));

    socket.onConnectError((error) {
      print('socket error ' + error.toString());
    });

    // socket.connect();
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

  @override
  UserPermission? getPermissions() {
    return permission;
  }
}
