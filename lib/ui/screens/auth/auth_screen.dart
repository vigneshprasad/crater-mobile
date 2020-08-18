import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worknetwork/blocs/auth/bloc/auth_bloc.dart';
import 'package:worknetwork/blocs/login/bloc/login_bloc.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/ui/base/base_form_input/base_form_input.dart';
import 'package:worknetwork/ui/base/social_auth_button/social_auth_button.dart';
import 'package:worknetwork/utils/app_localizations.dart';
import 'package:worknetwork/utils/navigation_helpers/navigate_post_auth.dart';

part 'login_form.dart';
part 'body.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  LoginBloc _loginBloc;
  AuthBloc _authBloc;
  NavigatorState _navigator;

  @override
  void initState() {
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _loginBloc = LoginBloc(_authBloc);
    _navigator = Navigator.of(context);
    super.initState();
  }

  @override
  void dispose() {
    _loginBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _loginBloc,
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.isAuth) {
            navigatePostAuth(_navigator, state.user);
          }
        },
        child: Scaffold(
          body: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  SignupBodyTemplate(
                    content: Column(
                      children: <Widget>[
                        socialAuthRow(context),
                        const SizedBox(
                          height: AppPadding.l,
                        ),
                        LoginForm()
                      ],
                    ),
                    onTapPlayButton: _onTapPlayButton,
                  ),
                  if (state.isSubmitting)
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.black.withOpacity(0.7),
                    )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Row socialAuthRow(BuildContext ctx) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SocialAuthButton(
          onPressed: () {
            _loginBloc.add(LoginWithGooglePressed());
          },
          provider: AuthProvider.google,
        ),
        const SizedBox(
          width: AppPadding.med,
        ),
        SocialAuthButton(
          onPressed: () {},
          provider: AuthProvider.facebook,
        ),
        const SizedBox(
          width: AppPadding.med,
        ),
        SocialAuthButton(
          onPressed: () {},
          provider: AuthProvider.linkedin,
        )
      ],
    );
  }

  void _onTapPlayButton() {}
}
