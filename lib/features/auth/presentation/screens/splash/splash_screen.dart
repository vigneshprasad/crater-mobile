import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart' hide ReadContext;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kiwi/kiwi.dart';
import 'package:worknetwork/core/integrations/user_leap/user_leap_provider.dart';

import '../../../../../core/widgets/base/base_container/scaffold_container.dart';
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
      child: const Scaffold(
        body: ScaffoldContainer(
          child: Center(
            child: Logo(),
          ),
        ),
      ),
    );
  }

  void listenAuthState(BuildContext context, AuthState state) {
    if (state is AuthStateFailure) {
      AutoRouter.of(context).root.popAndPush(const WelcomeScreenRoute());
    }

    if (state is AuthStateSuccess) {
      context.read(userLeapProvider).setUserData(state.user!);
      navigatePostAuth(state.user, profile: state.profile);
    }
  }
}
