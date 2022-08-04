import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/api/integrations/devices_api_service.dart';
import 'package:worknetwork/core/api_result/api_result.dart';
import 'package:worknetwork/core/push_notfications/push_notifications.dart';
import 'package:worknetwork/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:worknetwork/features/auth/data/repository/auth_repository_impl.dart';
import 'package:worknetwork/features/auth/domain/entity/user_entity.dart';

final splashStateProvider =
    StateNotifierProvider<SplashStateNotifier, ApiResult<User>>(
  (ref) => SplashStateNotifier(ref.read),
);

final authStateProvider =
    StateNotifierProvider<AuthStateNotifier, ApiResult<User>>(
  (ref) => AuthStateNotifier(ref.read),
);

final authTokenProvider = StateProvider(
  (ref) {
    final user =
        ref.read(authLocalDatasourceProvider).value?.getUserFromCache();
    return user?.token;
  },
);

class SplashStateNotifier extends StateNotifier<ApiResult<User>> {
  final Reader read;

  SplashStateNotifier(this.read) : super(ApiResult.loading()) {
    fetchUser();
  }

  Future<void> fetchUser() async {
    await read(authStateProvider.notifier).fetchUser();
    state = read(authStateProvider.notifier).state;
  }

  Future<bool> isLoggedIn() async {
    return read(authStateProvider.notifier).isLoggedIn();
  }
}

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
    final user = state.map(
      loading: (value) => null,
      data: (value) => value,
      error: (value) => null,
    );

    return user?.data;
  }

  void setUser(User user) {
    state = ApiResult.data(user);
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
