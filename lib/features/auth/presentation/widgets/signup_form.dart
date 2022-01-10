import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/theme.dart';
import '../../../../ui/base/base_form_input/base_form_input.dart';
import '../../../../ui/base/base_large_button/base_large_button.dart';
import '../../../../utils/app_localizations.dart';
import '../bloc/auth_bloc.dart';

class SignupForm extends StatefulWidget {
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late AuthBloc _authBloc;

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
    final email = AppLocalizations.of(context)?.translate("input_label_email");
    final password = AppLocalizations.of(context)?.translate("input_password");
    final name = AppLocalizations.of(context)?.translate("input_label_name");

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        bool isEnabled;
        if (state.isSubmitting == null) {
          isEnabled = true;
        } else {
          isEnabled = !state.isSubmitting!;
        }
        return Form(
          key: _formKey,
          child: Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BaseFormInput(
                  enabled: isEnabled,
                  controller: _nameController,
                  label: name!,
                  autovalidate: false,
                  validator: (value) {
                    return value == null || value.isEmpty
                        ? 'Name is Required'
                        : null;
                  },
                ),
                const SizedBox(
                  height: AppPadding.med,
                ),
                BaseFormInput(
                  enabled: isEnabled,
                  controller: _emailController,
                  label: email!,
                  validator: (text) {
                    if (text == null || text.isEmpty) return null;
                    if (state.isEmailValid == null) return null;
                    return !state.isEmailValid! ? 'Invalid Email' : null;
                  },
                ),
                const SizedBox(
                  height: AppPadding.med,
                ),
                BaseFormInput(
                  controller: _passwordController,
                  enabled: isEnabled,
                  maxLines: 1,
                  label: password!,
                  obscureText: true,
                  validator: (text) {
                    if (text == null || text.isEmpty) return null;
                    return !state.isPasswordValid ? 'Invalid Password' : null;
                  },
                ),
                const Spacer(),
                BaseLargeButton(
                  onPressed: _onRegisterEmailPressed,
                  text: "register",
                ),
                const SizedBox(height: AppInsets.xxl),
              ],
            ),
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
    final isValid = _formKey.currentState?.validate();
    if (isValid ?? false) {
      _authBloc.add(AuthRegisterEmailPressed(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      ));
    }
  }
}
