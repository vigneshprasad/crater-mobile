import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_linkedin/linkedloginflutter.dart';
import 'package:kiwi/kiwi.dart';
import 'package:worknetwork/core/error/failures.dart';
import 'package:worknetwork/core/push_notfications/push_notifications.dart';
import 'package:worknetwork/features/auth/presentation/widgets/signup_form.dart';
import 'package:worknetwork/ui/base/base_large_button/base_large_button.dart';

import '../../../../../constants/app_constants.dart';
import '../../../../../constants/theme.dart';
import '../../../../../ui/base/base_form_input/base_form_input.dart';
import '../../../../../ui/base/social_auth_button/social_auth_button.dart';
import '../../../../../utils/app_localizations.dart';
import '../../../../../utils/navigation_helpers/navigate_post_auth.dart';
import '../../../../social_auth/domain/usecase/get_social_auth_token.dart';
import '../../bloc/auth_bloc.dart';

part '../../widgets/auth_screen_body.dart';
part '../../widgets/login_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthBloc _authBloc;
  ExtendedNavigatorState _navigator;

  @override
  void initState() {
    LinkedInLogin.initialize(
      context,
      clientId: AppConstants.linkedinClientId,
      clientSecret: AppConstants.linkedinSecret,
      redirectUri: AppConstants.linkedinRedirect,
    );
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _navigator = ExtendedNavigator.root;
    super.initState();
  }

  Future<void> _showOsId() async {
    final odId = await KiwiContainer()
        .resolve<PushNotifications>()
        .getSubscribtionsToken();
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(odId),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthStateSuccess) {
          navigatePostAuth(_navigator, state.user);
        } else if (state is AuthRequestFailure) {
          _handleRequestError(state);
        }
      },
      child: Scaffold(
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Stack(
              fit: StackFit.expand,
              children: <Widget>[
                AuthScreenBody(
                  content: Column(
                    children: <Widget>[
                      _socialAuthRow(context),
                      const SizedBox(
                        height: 44,
                      ),
                      // LoginForm()
                      SignupForm()
                    ],
                  ),
                  // onTapPlayButton: _onTapPlayButton,
                ),
                if (state.isSubmitting != null && state.isSubmitting)
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
    );
  }

  void _handleRequestError(AuthRequestFailure state) {
    final failure = state.error as ServerFailure;
    if (failure.message != null) {
      final json = jsonDecode(failure.message.toString());
      showDialog(
        context: context,
        builder: (context) {
          final title =
              AppLocalizations.of(context).translate("auth:login_fail_title");
          final dismiss =
              AppLocalizations.of(context).translate("dismiss").toUpperCase();
          return AlertDialog(
            title: Text(title),
            content: Text(json["non_field_errors"][0] as String),
            actions: [
              FlatButton(
                onPressed: () {
                  ExtendedNavigator.of(context).pop();
                },
                child: Text(dismiss),
              )
            ],
          );
        },
      );
    }
  }

  Row _socialAuthRow(BuildContext ctx) {
    final socialAuthProvider = [
      SocialAuthProviders.google,
      SocialAuthProviders.facebook,
      SocialAuthProviders.linkedin,
    ];

    final List<Widget> socialbuttonList = socialAuthProvider.fold(
      [],
      (previousValue, element) {
        final items = [
          SocialAuthButton(
            provider: element,
            onPressed: () =>
                _authBloc.add(AuthSocialPressed(provider: element)),
          ),
          if (element.index != socialAuthProvider.length - 1)
            const SizedBox(
              width: AppPadding.med,
            ),
        ];
        return [...previousValue, ...items];
      },
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[...socialbuttonList],
    );
  }
}
