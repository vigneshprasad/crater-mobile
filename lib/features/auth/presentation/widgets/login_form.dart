part of '../screens/auth/auth_screen.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String email =
        AppLocalizations.of(context).translate("input_label_email");
    final String password =
        AppLocalizations.of(context).translate("input_password");

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        bool isEnabled;
        if (state.isSubmitting == null) {
          isEnabled = true;
        } else {
          isEnabled = !state.isSubmitting;
        }
        return Form(
          child: Expanded(
            child: Column(
              children: <Widget>[
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
                const SizedBox(height: AppPadding.med),
                BaseFormInput(
                  controller: _passwordController,
                  enabled: isEnabled,
                  label: password,
                  obscureText: true,
                  maxLines: 1,
                  validator: (text) {
                    if (text.isEmpty) return null;
                    return !state.isPasswordValid ? 'Invalid Password' : null;
                  },
                ),
                const Spacer(),
                BaseLargeButton(
                  onPressed: _onLoginEmailPressed,
                  text: "login",
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
    _authBloc.add(
      AuthEmailChanged(email: _emailController.text),
    );
  }

  void _onLoginPasswordChanged() {
    _authBloc.add(
      AuthPaswordChanged(password: _passwordController.text),
    );
  }

  void _onLoginEmailPressed() {
    _authBloc.add(
      AuthLoginEmailPressed(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }
}
