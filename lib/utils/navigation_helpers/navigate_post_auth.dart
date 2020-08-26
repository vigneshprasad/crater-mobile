import 'package:auto_route/auto_route.dart';
import 'package:worknetwork/features/auth/domain/entity/user_entity.dart';

import '../../routes.gr.dart';

void navigatePostAuth(ExtendedNavigatorState navigator, User user) {
  if (user.hasProfile == null) {
    navigator.popAndPush(Routes.setupScreen, arguments: 'basic_profile');
  } else if (user.hasServices == null) {
    navigator.popAndPush(Routes.setupScreen, arguments: 'services');
  } else if (user.phoneNumberVerified == null) {
    navigator.popAndPush(Routes.setupScreen, arguments: 'phone');
  } else {
    navigator.popAndPush(Routes.homeScreen);
  }
}
