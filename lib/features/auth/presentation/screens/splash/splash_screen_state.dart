import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worknetwork/api/integrations/devices_api_service.dart';
import 'package:worknetwork/core/api_result/api_result.dart';
import 'package:worknetwork/core/features/socket_io/socket_io_manager.dart';
import 'package:worknetwork/core/push_notfications/push_notifications.dart';
import 'package:worknetwork/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:worknetwork/features/auth/data/repository/auth_repository_impl.dart';
import 'package:worknetwork/features/auth/domain/entity/user_entity.dart';

const craterSplashKey = 'crater_splash_shown';

enum SplashState {
  home,
  login,
  intro,
  name,
  email,
}

final splashStateProvider = FutureProvider<SplashState>(
  (ref) async {
    // Delay for splash video play
    await Future.delayed(
      const Duration(seconds: 2),
    );

    final authState =
        await ref.read(authRepositoryProvider).getAuthenticationState();
    final isLoggedIn = authState.fold((error) => false, (data) => true);

    if (isLoggedIn) {
      final socketIOManager = ref.read(userPermissionNotifierProvider.notifier);
      await socketIOManager.listenPermissions();

      await ref.read(authStateProvider.notifier).fetchUser();

      final user = ref.read(authStateProvider.notifier).getUser();
      if (user?.name == null || user!.name!.trim().isEmpty) {
        return SplashState.name;
      }

      if (user.email == null || user.email!.trim().isEmpty) {
        return SplashState.email;
      }

      return SplashState.home;
    }

    final splashStatus = await getStatus(craterSplashKey);
    saveStatus(craterSplashKey);

    if (splashStatus) {
      return SplashState.login;
    } else {
      return SplashState.intro;
    }
  },
);

Future<bool> getStatus(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool(key) ?? false;
}

Future<void> saveStatus(String key) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool(key, true);
}

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

  void clear() {
    state = ApiResult.loading();
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
