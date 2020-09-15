import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../routes.gr.dart';
import '../../../../../ui/base/logo/logo.dart';
import '../../../../../utils/navigation_helpers/navigate_post_auth.dart';
import '../../bloc/auth_bloc.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
    if (state is AuthStateFailure) {
      ExtendedNavigator.of(context).popAndPush(Routes.authScreen);
    }

    if (state is AuthStateSuccess) {
      navigatePostAuth(state.user);
    }
  }
}
