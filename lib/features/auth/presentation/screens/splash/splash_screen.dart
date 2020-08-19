import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worknetwork/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:worknetwork/routes.dart';
import 'package:worknetwork/ui/base/logo/logo.dart';
import 'package:worknetwork/utils/navigation_helpers/navigate_post_auth.dart';

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
    final NavigatorState _navigator = Navigator.of(context);
    if (state is AuthStateFailure) {
      _navigator.pushReplacementNamed(Routes.auth);
    }

    if (state is AuthStateSuccess) {
      navigatePostAuth(_navigator, state.user);
    }
  }
}
