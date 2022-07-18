import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/api/integrations/devices_api_service.dart';
import 'package:worknetwork/core/api_result/api_result.dart';
import 'package:worknetwork/core/push_notfications/push_notifications.dart';
import 'package:worknetwork/features/auth/data/repository/auth_repository_impl.dart';
import 'package:worknetwork/features/auth/domain/entity/user_entity.dart';

final authStateProvider =
    StateNotifierProvider<AuthStateNotifier, ApiResult<User>>(
  (ref) => AuthStateNotifier(ref.read),
);

class AuthStateNotifier extends StateNotifier<ApiResult<User>> {
  final Reader read;

  AuthStateNotifier(this.read) : super(ApiResult.loading()) {
    fetchUser();
  }

  Future<void> fetchUser() async {
    final loginState = await isLoggedIn();
    if (loginState == false) {
      state = ApiResult.error(null);
      return;
    }
    final userResult = await read(authRepositoryProvider).getUser();
    userResult.fold((error) {
      state = ApiResult.error(null);
    }, (user) {
      state = ApiResult.data(user);
    });
  }

  Future<bool> isLoggedIn() async {
    final isLoggedIn =
        await read(authRepositoryProvider).getAuthenticationState();
    return isLoggedIn.getOrElse(() => false);
  }

  User? getUser() {
    return state.mapOrNull();
  }

  Future<void> registerDevice() async {
    final osId = await read(pushNotificationsProvider).getSubscriptionToken();

    final Map<String, String> data = {
      'os_id': osId,
    };

    final user = state.whenOrNull() as User?;
    final userId = user?.pk;
    if (userId != null) {
      data['user'] = userId;
    }

    // 'user': null,
    final deviceAPI = read(devicesApiServiceProvider);
    await deviceAPI.registerDevice(data).then((response) {});
  }
}
