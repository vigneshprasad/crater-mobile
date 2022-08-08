import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player/video_player.dart';
import 'package:worknetwork/core/widgets/base/base_container/scaffold_container.dart';
import 'package:worknetwork/core/widgets/screens/home_screen/home_screen.dart';
import 'package:worknetwork/features/auth/presentation/screens/phone/phone_screen.dart';
import 'package:worknetwork/features/auth/presentation/screens/splash/splash_screen_state.dart';
import 'package:worknetwork/features/auth/presentation/screens/welcome/welcome_screen.dart';

class SplashScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controllerState =
        useState(VideoPlayerController.asset('assets/video/intro.mp4'));
    final controller = controllerState.value;
    controller.setVolume(0);
    // controller.addListener(() {});
    controller.initialize().then((value) {});
    controller.play();

    return FutureBuilder<SplashState>(
      future: ref.watch(splashStateProvider.future),
      builder: (context, snapshot) {
        switch (snapshot.data) {
          case SplashState.home:
            return const HomeScreen();
          case SplashState.login:
            return PhoneScreen();
          case SplashState.intro:
            return WelcomeScreen();
          default:
            return Scaffold(
              body: ScaffoldContainer(
                child: AspectRatio(
                  aspectRatio: controller.value.aspectRatio,
                  child: VideoPlayer(controller),
                ),
              ),
            );
        }
      },
    );
  }
}
