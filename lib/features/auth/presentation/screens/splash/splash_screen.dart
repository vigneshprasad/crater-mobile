import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart' hide ReadContext;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kiwi/kiwi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worknetwork/api/integrations/devices_api_service.dart';
import 'package:worknetwork/core/push_notfications/push_notifications.dart';

import '../../../../../core/widgets/base/base_container/scaffold_container.dart';
import '../../../../../routes.gr.dart';
import '../../../../../ui/base/logo/logo.dart';
import '../../../../../utils/navigation_helpers/navigate_post_auth.dart';
import '../../bloc/auth_bloc.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

const craterSplashKey = 'crater_splash_shown';

class _SplashScreenState extends State<SplashScreen> {
  bool isRedirected = false;

  @override
  void initState() {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    authBloc.add(AuthStarted());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: listenAuthState,
      child: const Scaffold(
        body: ScaffoldContainer(
          child: Center(
            child: Logo(
              withText: false,
            ),
          ),
        ),
      ),
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

  Future<void> listenAuthState(BuildContext context, AuthState state) async {
    final osId = await KiwiContainer()
        .resolve<PushNotifications>()
        .getSubscriptionToken();
    debugPrint(osId);

    Map<String, String> data = {
      'os_id': osId,
    };
    final user = BlocProvider.of<AuthBloc>(context).state.user?.pk;
    if (user != null) {
      data['user'] = user;
    }

    // 'user': null,
    final deviceAPI = context.read(devicesApiServiceProvider);
    deviceAPI.registerDevice(data).then((response) {
      debugPrint(response.toString());
    });

    if (state is AuthStateFailure) {
      isRedirected = true;

      final splashShown = await getStatus(craterSplashKey);

      if (!splashShown) {
        await saveStatus(craterSplashKey);

        AutoRouter.of(context).root.pushAndPopUntil(const WelcomeScreenRoute(),
            predicate: (route) => false);

        return;
      }

      navigatePostAuth(state.user, profile: state.profile);
    }

    if (state is AuthStateSuccess && !isRedirected) {
      isRedirected = true;
      navigatePostAuth(state.user, profile: state.profile);
    }
  }
}
