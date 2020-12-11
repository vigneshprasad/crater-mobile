import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kiwi/kiwi.dart';

import '../../../../../constants/theme.dart';
import '../../../../../ui/base/base_form_input/base_form_input.dart';
import '../../../../../ui/base/base_large_button/base_large_button.dart';
import '../../../../../utils/app_localizations.dart';
import '../../bloc/forgot_password/forgot_password_bloc.dart';
import '../auth/auth_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ForgotPasswordBloc _bloc;
  String email;

  @override
  void initState() {
    _bloc = KiwiContainer().resolve<ForgotPasswordBloc>();
    _emailController.addListener(_onChangeEmail);
    super.initState();
  }

  void _onChangeEmail() {
    _bloc.add(ForgotPasswordEmailChanged(email: _emailController.text));
    setState(() {
      email = _emailController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: _bloc,
        child: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
          listener: _blocListener,
          builder: (context, state) {
            return Scaffold(
              body: AuthScreenBody(
                content: Form(
                  key: _formKey,
                  child: _buildContent(context, state),
                ),
              ),
            );
          },
        ));
  }

  @override
  void dispose() {
    _bloc.close();
    _emailController.dispose();
    super.dispose();
  }

  void _blocListener(BuildContext context, ForgotPasswordState state) {
    if (state is ForgotPasswordSuccess) {
      Fluttertoast.showToast(
        msg: "Pasword reset email sent to $email",
        backgroundColor: Colors.grey[800],
        textColor: Colors.white,
      );
      ExtendedNavigator.of(context).pop(email);
    }
  }

  Widget _buildContent(BuildContext context, ForgotPasswordState state) {
    final String forgotPassword =
        AppLocalizations.of(context).translate("auth:forgot_password");
    final String desc =
        AppLocalizations.of(context).translate("auth:forgot_password_desc");
    final headingStyle = Theme.of(context).textTheme.headline6.copyWith(
          fontSize: 20,
          color: Colors.grey[700],
        );
    final descStyle = Theme.of(context).textTheme.bodyText2.copyWith(
          color: Colors.grey[500],
        );

    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Text(
            forgotPassword,
            textAlign: TextAlign.center,
            style: headingStyle,
          ),
          const SizedBox(height: AppInsets.l),
          Text(
            desc,
            textAlign: TextAlign.center,
            style: descStyle,
          ),
          const SizedBox(height: AppInsets.xl),
          BaseFormInput(
            autovalidate: false,
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            label: "Email address",
            validator: (value) {
              if (value.isEmpty) return "Please enter an email address";
              return !state.isEmailValid
                  ? "Please enter a valid email address"
                  : null;
            },
          ),
          const Spacer(),
          BaseLargeButton(
            enabled: !state.isSubmitting,
            onPressed: _submitForm,
            text: "Submit",
          ),
          const SizedBox(height: AppInsets.xxl),
        ],
      ),
    );
  }

  void _submitForm() {
    final isValid = _formKey.currentState.validate();
    if (isValid) {
      _bloc.add(ForgotPasswordRequestStarted(email: email));
    }
  }
}
