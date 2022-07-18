import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worknetwork/core/widgets/base/base_container/scaffold_container.dart';
import 'package:worknetwork/core/widgets/screens/home_screen/home_screen.dart';
import 'package:worknetwork/features/auth/presentation/screens/splash/splash_screen_state.dart';
import 'package:worknetwork/features/auth/presentation/screens/welcome/welcome_screen.dart';
import 'package:worknetwork/ui/base/logo/logo.dart';

const craterSplashKey = 'crater_splash_shown';

class SplashScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    ref.read(authStateProvider.notifier).registerDevice();

    return authState.when(
      loading: () => const Scaffold(
        body: ScaffoldContainer(
          child: Center(
            child: Logo(
              withText: false,
            ),
          ),
        ),
      ),
      data: (data) {
        return const HomeScreen();
      },
      error: (error, stack) {
        final statusFuture = getStatus(craterSplashKey);
        return FutureBuilder<bool>(
          future: statusFuture,
          builder: (context, snapshot) {
            if (snapshot.data == true) {
              return const HomeScreen();
            }
            saveStatus(craterSplashKey);

            return WelcomeScreen();
          },
        );
      },
    );
  }

  Future<bool> getStatus(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }

  Future<void> saveStatus(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, true);
  }
}
