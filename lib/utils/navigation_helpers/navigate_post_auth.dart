import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kiwi/kiwi.dart';
import 'package:worknetwork/features/auth/presentation/screens/onboarding/onboarding_screen_state.dart';

import '../../core/push_notfications/push_notifications.dart';
import '../../features/auth/domain/entity/user_entity.dart';
import '../../features/auth/domain/entity/user_profile_entity.dart';
import '../../routes.gr.dart';

void navigatePostAuth(User user, {UserProfile profile}) {
  final GlobalKey<NavigatorState> _navigator = KiwiContainer().resolve();
  if (profile == null || profile.educationLevel == null) {
    _navigator.currentState.pushNamedAndRemoveUntil(
        Routes.profileBasicScreen(editMode: false), (route) => false);
  } else if (user.phoneNumberVerified == false) {
    _navigator.currentState.pushNamedAndRemoveUntil(
        Routes.phoneVerificationScreen, (route) => false);
  } else {
    _navigateToHome(_navigator);

    KiwiContainer().resolve<PushNotifications>().setEventHandlers();
  }
}

Future<void> _navigateToHome(GlobalKey<NavigatorState> navigator) async {
  final onboarding = ProviderContainer().read(onboardingProvider);

  final shown = await onboarding.getOnboardingKey();

  if (shown) {
    navigator.currentState.popAndPushNamed(Routes.homeScreen(tab: 0));
  } else {
    navigator.currentState.popAndPushNamed(Routes.onboardingScreen);
  }
}
