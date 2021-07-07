import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart';

import '../../core/push_notfications/push_notifications.dart';
import '../../features/auth/domain/entity/user_entity.dart';
import '../../features/auth/domain/entity/user_profile_entity.dart';
import '../../routes.gr.dart';

void navigatePostAuth(User user, {UserProfile profile}) {
  final GlobalKey<NavigatorState> _navigator = KiwiContainer().resolve();
  if (user != null) {
    if (profile == null) {
      _navigator.currentState.pushNamedAndRemoveUntil(
          Routes.profileBasicScreen(editMode: false), (route) => false);
    } else if (profile.tagList == null || profile.tagList.isEmpty) {
      _navigator.currentState.pushNamedAndRemoveUntil(
          Routes.profileTagsScreen(editMode: false), (route) => false);
    } else if (profile.profileIntroUpdated == false) {
      _navigator.currentState.pushNamedAndRemoveUntil(
          Routes.profileExtraInfoScreen, (route) => false);
    } else if (profile.photo == null) {
      _navigator.currentState.pushNamedAndRemoveUntil(
          Routes.profileImageScreen(editMode: false), (route) => false);
    } else {
      _navigator.currentState
          .pushNamedAndRemoveUntil(Routes.homeScreen(tab: 0), (route) => false);
    }
  } else if (user.phoneNumberVerified == false) {
    _navigator.currentState.pushNamedAndRemoveUntil(
        Routes.phoneVerificationScreen, (route) => false);
  } else {
    _navigator.currentState.popAndPushNamed(Routes.homeScreen(tab: 0));
    KiwiContainer().resolve<PushNotifications>().setEventHandlers();
  }
}
