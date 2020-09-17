import 'dart:convert';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_linkedin/linkedloginflutter.dart';

import '../../../../../constants/app_constants.dart';
import '../../../../../constants/theme.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../ui/base/base_form_input/base_form_input.dart';
import '../../../../../ui/base/base_large_button/base_large_button.dart';
import '../../../../../ui/base/social_auth_button/social_auth_button.dart';
import '../../../../../utils/app_localizations.dart';
import '../../../../../utils/navigation_helpers/navigate_post_auth.dart';
import '../../../../social_auth/domain/usecase/get_social_auth_token.dart';
import '../../bloc/auth_bloc.dart';
import '../../widgets/signup_form.dart';

part '../../widgets/auth_screen_body.dart';
part '../../widgets/login_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthBloc _authBloc;
  int _formIndex = 0;

  @override
  void initState() {
    LinkedInLogin.initialize(
      context,
      clientId: AppConstants.linkedinClientId,
      clientSecret: AppConstants.linkedinSecret,
      redirectUri: AppConstants.linkedinRedirect,
    );
    _authBloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthStateSuccess) {
          navigatePostAuth(state.user);
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
                      const SizedBox(height: 32),
                      // LoginForm()
                      if (_formIndex == 0) SignupForm() else LoginForm()
                    ],
                  ),
                  footer: _buildFooter(context),
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

    if (Platform.isIOS) {
      socialAuthProvider.add(SocialAuthProviders.apple);
    }

    final List<Widget> socialbuttonList = socialAuthProvider.map(
      (element) {
        final isLast =
            socialAuthProvider.indexOf(element) == socialAuthProvider.length;
        return Padding(
          padding: EdgeInsets.only(right: isLast ? 0 : AppInsets.med),
          child: SocialAuthButton(
            provider: element,
            onPressed: () =>
                _authBloc.add(AuthSocialPressed(provider: element)),
          ),
        );
      },
    ).toList();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[...socialbuttonList],
    );
  }

  Widget _buildFooter(BuildContext context) {
    final bodyTextKey =
        _formIndex == 0 ? "auth:signin_text" : "auth:signup_text";
    final clickTextKey = _formIndex == 0 ? "auth:signin" : "auth:signup";
    final bodyStyle = Theme.of(context).textTheme.bodyText2;
    final clickStyle = bodyStyle.copyWith(
      color: Theme.of(context).primaryColor,
    );
    final bodyText = AppLocalizations.of(context).translate(bodyTextKey);
    final clickText = AppLocalizations.of(context).translate(clickTextKey);
    return Container(
      height: AppTheme.appBarHeight.height,
      color: Colors.grey[200],
      child: Center(
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(text: bodyText, style: bodyStyle),
              TextSpan(
                text: " $clickText",
                style: clickStyle,
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    if (_formIndex == 0) {
                      setState(() {
                        _formIndex = 1;
                      });
                    } else {
                      setState(() {
                        _formIndex = 0;
                      });
                    }
                  },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
