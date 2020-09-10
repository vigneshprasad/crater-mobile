import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:worknetwork/ui/base/base_form_input/base_form_input.dart';
import 'package:worknetwork/ui/base/base_large_button/base_large_button.dart';
import 'package:worknetwork/utils/app_localizations.dart';

class SignupForm extends StatefulWidget {
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AuthBloc _authBloc;

  @override
  void initState() {
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _emailController.addListener(_onLoginEmailChanged);
    _passwordController.addListener(_onLoginPasswordChanged);
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String email =
        AppLocalizations.of(context).translate("input_label_email");
    final String password =
        AppLocalizations.of(context).translate("input_password");
    final String name =
        AppLocalizations.of(context).translate("input_label_name");

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        bool isEnabled;
        if (state.isSubmitting == null) {
          isEnabled = true;
        } else {
          isEnabled = !state.isSubmitting;
        }
        const buttonSpacer = 64.00;
        return Form(
          key: _formKey,
          child: Column(
            children: [
              BaseFormInput(
                enabled: isEnabled,
                controller: _nameController,
                label: name,
                autovalidate: false,
                validator: (value) {
                  return value.isEmpty ? 'Name is Required' : null;
                },
              ),
              const SizedBox(
                height: AppPadding.med,
              ),
              BaseFormInput(
                enabled: isEnabled,
                controller: _emailController,
                label: email,
                validator: (text) {
                  if (text.isEmpty) return null;
                  if (state.isEmailValid == null) return null;
                  return !state.isEmailValid ? 'Invalid Email' : null;
                },
              ),
              const SizedBox(
                height: AppPadding.med,
              ),
              BaseFormInput(
                controller: _passwordController,
                enabled: isEnabled,
                label: password,
                obscureText: true,
                validator: (text) {
                  if (text.isEmpty) return null;
                  return !state.isPasswordValid ? 'Invalid Password' : null;
                },
              ),
              const SizedBox(
                height: buttonSpacer,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: BaseLargeButton(
                  onPressed: _onRegisterEmailPressed,
                  text: "register",
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _onLoginEmailChanged() {
    _authBloc.add(AuthEmailChanged(email: _emailController.text));
  }

  void _onLoginPasswordChanged() {
    _authBloc.add(AuthPaswordChanged(password: _passwordController.text));
  }

  void _onRegisterEmailPressed() {
    final isValid = _formKey.currentState.validate();
    if (isValid) {
      _authBloc.add(AuthRegisterEmailPressed(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      ));
    }
  }
}
