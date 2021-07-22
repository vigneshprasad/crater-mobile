import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart';

import '../../core/push_notfications/push_notifications.dart';
import '../../features/auth/domain/entity/user_entity.dart';
import '../../features/auth/domain/entity/user_profile_entity.dart';
import '../../routes.gr.dart';

void navigatePostAuth(User? user, {UserProfile? profile}) {
  final GlobalKey<NavigatorState> _navigator = KiwiContainer().resolve();
  if (user != null) {
    if (profile == null) {
      _navigator.currentState?.pushNamedAndRemoveUntil(
          ProfileBasicScreenRoute.name, (route) => false);
    } else if (profile.tagList == null || profile.tagList!.isEmpty) {
      _navigator.currentState?.pushNamedAndRemoveUntil(
          ProfileTagsScreenRoute.name, (route) => false);
    } else if (profile.profileIntroUpdated == false) {
      _navigator.currentState?.pushNamedAndRemoveUntil(
          ProfileExtraInfoScreenRoute.name, (route) => false);
    } else if (profile.photo == null) {
      _navigator.currentState?.pushNamedAndRemoveUntil(
          ProfileImageScreenRoute.name, (route) => false);
    } else {
      _navigator.currentState
          ?.pushNamedAndRemoveUntil(HomeScreenRoute.name, (route) => false);
    }
  } else if (user!.phoneNumberVerified == false) {
    _navigator.currentState?.pushNamedAndRemoveUntil(
        PhoneVerificationScreenRoute.name, (route) => false);
  } else {
    _navigator.currentState?.popAndPushNamed(HomeScreenRoute.name);
    KiwiContainer().resolve<PushNotifications>().setEventHandlers();
  }
}
