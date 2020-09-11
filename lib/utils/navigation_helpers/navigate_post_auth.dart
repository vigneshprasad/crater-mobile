import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart';
import 'package:worknetwork/features/auth/domain/entity/user_entity.dart';

import '../../routes.gr.dart';

void navigatePostAuth(ExtendedNavigatorState navigator, User user) {
  final GlobalKey<NavigatorState> _navigator = KiwiContainer().resolve();
  if (user.objectives.isEmpty) {
    _navigator.currentState.popAndPushNamed(Routes.objectivesScreen);
  } else if (user.linkedinUrl == null) {
    _navigator.currentState.popAndPushNamed(Routes.profileSetupScreen);
  } else if (user.phoneNumberVerified == false) {
    _navigator.currentState.popAndPushNamed(Routes.phoneVerificationScreen);
  } else {
    _navigator.currentState.popAndPushNamed(Routes.homeScreen(tab: 0));
  }
}
