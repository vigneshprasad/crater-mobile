import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worknetwork/blocs/auth/bloc/auth_bloc.dart';
import 'package:worknetwork/routes.dart';
import 'package:worknetwork/ui/base/logo/logo.dart';
import 'package:worknetwork/utils/navigation_helpers/navigate_post_auth.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: listenAuthState,
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: const Center(
            child: Logo(),
          ),
        ),
      ),
    );
  }

  void listenAuthState(BuildContext context, AuthState state) {
    final NavigatorState _navigator = Navigator.of(context);
    if (!state.isAuth) {
      _navigator.pushReplacementNamed(Routes.auth);
    }

    if (state.isAuth) {
      navigatePostAuth(_navigator, state.user);
    }
  }
}
