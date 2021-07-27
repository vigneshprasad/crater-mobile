import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart';

import '../../core/push_notfications/push_notifications.dart';
import '../../features/auth/domain/entity/user_entity.dart';
import '../../features/auth/domain/entity/user_profile_entity.dart';
import '../../routes.gr.dart';

void navigatePostAuth(User? user, {UserProfile? profile}) {
  final GlobalKey<NavigatorState> _navigator = KiwiContainer().resolve();
  final router = AutoRouter.of(_navigator.currentContext!).root;
  if (user != null) {
    if (profile == null) {
      router.pushAndPopUntil(ProfileBasicScreenRoute(editMode: false),
          predicate: (route) => false);
    } else if (profile.tagList == null || profile.tagList!.isEmpty) {
      router.pushAndPopUntil(ProfileTagsScreenRoute(editMode: false),
          predicate: (route) => false);
    } else if (profile.profileIntroUpdated == false) {
      router.pushAndPopUntil(const ProfileExtraInfoScreenRoute(),
          predicate: (route) => false);
    } else if (profile.photo == null) {
      router.pushAndPopUntil(ProfileImageScreenRoute(editMode: false),
          predicate: (route) => false);
    } else if (user.phoneNumberVerified == false) {
      router.pushAndPopUntil(const PhoneVerificationScreenRoute(),
          predicate: (route) => false);
    } else {
      router.pushAndPopUntil(HomeScreenRoute(), predicate: (route) => false);
    }
  } else {
    router.pushAndPopUntil(HomeScreenRoute(), predicate: (route) => false);
    KiwiContainer().resolve<PushNotifications>().setEventHandlers();
  }
}
