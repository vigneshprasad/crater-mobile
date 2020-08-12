import 'package:flutter/material.dart';
import 'package:worknetwork/models/user/user_model.dart';
import 'package:worknetwork/routes.dart';

void navigatePostAuth(NavigatorState navigator, User user) {
  if (user.hasProfile == null) {
    navigator.pushReplacementNamed(Routes.setup, arguments: 'basic_profile');
  } else if (user.hasServices == null) {
    navigator.pushReplacementNamed(Routes.setup, arguments: 'services');
  } else if (user.phoneNumberVerified == null) {
    navigator.pushReplacementNamed(Routes.setup, arguments: 'phone');
  } else {
    navigator.pushReplacementNamed(Routes.home);
  }
}
