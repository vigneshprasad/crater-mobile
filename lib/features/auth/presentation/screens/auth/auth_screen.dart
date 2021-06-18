import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:auto_route/auto_route_annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide ReadContext;
import 'package:flutter_linkedin/linkedloginflutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/core/integrations/user_leap/user_leap_provider.dart';

import '../../../../../constants/theme.dart';
import '../../../../../core/config_reader/config_reader.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/widgets/base/base_container/scaffold_container.dart';
import '../../../../../routes.gr.dart';
import '../../../../../ui/base/base_app_bar/base_app_bar.dart';
import '../../../../../ui/base/base_form_input/base_form_input.dart';
import '../../../../../ui/base/base_large_button/base_large_button.dart';
import '../../../../../utils/app_localizations.dart';
import '../../../../../utils/navigation_helpers/navigate_post_auth.dart';
import '../../bloc/auth_bloc.dart';
import '../../widgets/signup_form.dart';

part '../../widgets/auth_screen_body.dart';
part '../../widgets/login_form.dart';

class AuthScreen extends StatefulWidget {
  final String state;

  const AuthScreen({
    Key key,
    @PathParam("state") this.state = "signup",
  }) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthBloc _authBloc;
  int _formIndex;

  @override
  void initState() {
    _formIndex = widget.state == "signup" ? 0 : 1;
    LinkedInLogin.initialize(
      context,
      clientId: ConfigReader.getLinkedInClientId(),
      clientSecret: ConfigReader.getLinkedInSecret(),
      redirectUri: ConfigReader.getLinkedInRedirect(),
    );
    _authBloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    _authBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthStateSuccess) {
          context.read(userLeapProvider).setUserData(state.user);
          navigatePostAuth(state.user, profile: state.profile);
        } else if (state is AuthRequestFailure) {
          _handleRequestError(state);
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: BaseAppBar(),
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return ScaffoldContainer(
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  AuthScreenBody(
                    content: Column(
                      children: <Widget>[
                        const SizedBox(height: 32),
                        if (_formIndex == 0) SignupForm() else LoginForm()
                      ],
                    ),
                  ),
                  if (state.isSubmitting != null && state.isSubmitting)
                    _buildOverlay(context)
                ],
              ),
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
    } else {
      Fluttertoast.showToast(msg: 'Some error occurred.');
    }
  }

  Widget _buildOverlay(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black.withOpacity(0.7),
      child: Center(
        child: Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: Theme.of(context).dialogBackgroundColor,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              SizedBox(
                height: 32,
                width: 32,
                child: CircularProgressIndicator(),
              ),
              SizedBox(height: AppInsets.xl),
              Text("Loading..."),
            ],
          ),
        ),
      ),
    );
  }
}
