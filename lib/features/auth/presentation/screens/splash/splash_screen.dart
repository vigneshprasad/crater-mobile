import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:worknetwork/core/widgets/base/base_container/scaffold_container.dart';
import 'package:worknetwork/core/widgets/screens/home_screen/home_screen.dart';
import 'package:worknetwork/features/auth/presentation/screens/splash/splash_screen_state.dart';
import 'package:worknetwork/features/auth/presentation/screens/welcome/welcome_screen.dart';

const craterSplashKey = 'crater_splash_shown';

class SplashScreen extends HookConsumerWidget {
  late VideoPlayerController controller;

  Future<bool> waitForVideo() async {
    await Future.delayed(
      const Duration(seconds: 2),
    );
    return true;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    controller = VideoPlayerController.asset('assets/video/intro.mp4');
    controller.setVolume(0);
    // controller.addListener(() {});
    controller.initialize().then((value) {});
    controller.play();

    return FutureBuilder(
      future: waitForVideo(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          ref.read(authStateProvider.notifier).registerDevice();
          final authState = ref.watch(splashStateProvider);
          return authState.when(
            loading: () => Scaffold(
              body: ScaffoldContainer(
                child: VideoPlayer(controller),
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

        return Scaffold(
          body: ScaffoldContainer(
            child: AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: VideoPlayer(controller),
            ),
          ),
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
