part of 'auth_screen.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginBloc _loginBloc;

  @override
  void initState() {
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(_onLoginEmailChanged);
    _passwordController.addListener(_onLoginPasswordChanged);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String email =
        AppLocalizations.of(context).translate("input_label_email");
    final String password =
        AppLocalizations.of(context).translate("input_password");

    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Form(
          child: Column(
            children: <Widget>[
              BaseFormInput(
                enabled: !state.isSubmitting,
                controller: _emailController,
                label: email,
                validator: (text) {
                  if (text.isEmpty) return null;
                  return !state.isEmailValid ? 'Invalid Email' : null;
                },
              ),
              const SizedBox(
                height: AppPadding.med,
              ),
              BaseFormInput(
                controller: _passwordController,
                enabled: !state.isSubmitting,
                label: password,
                obscureText: true,
                validator: (text) {
                  if (text.isEmpty) return null;
                  return !state.isPasswordValid ? 'Invalid Password' : null;
                },
              ),
              FlatButton(
                onPressed: _onLoginEmailPressed,
                child: const Text('Login'),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginEmailChanged() {
    _loginBloc.add(
      LoginEmailChanged(email: _emailController.text),
    );
  }

  void _onLoginPasswordChanged() {
    _loginBloc.add(
      LoginPasswordChanged(password: _passwordController.text),
    );
  }

  void _onLoginEmailPressed() {
    _loginBloc.add(
      LoginWithEmailPressed(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }
}
