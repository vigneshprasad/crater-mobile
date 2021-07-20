import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kiwi/kiwi.dart';

import '../../../../../constants/theme.dart';
import '../../../../../ui/base/base_form_input/base_form_input.dart';
import '../../../../../ui/base/base_large_button/base_large_button.dart';
import '../../../../../utils/app_localizations.dart';
import '../../bloc/new_password/new_password_bloc.dart';
import '../auth/auth_screen.dart';

class NewPasswordScreen extends StatefulWidget {
  final String params;

  const NewPasswordScreen({
    Key key,
    @PathParam("params") this.params,
  }) : super(key: key);

  @override
  _NewPasswordScreenState createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  NewPasswordBloc _bloc;
  String password;

  @override
  void initState() {
    _bloc = KiwiContainer().resolve<NewPasswordBloc>();
    _passwordController.addListener(_onNewPasswordChanged);
    _passwordConfirmController.addListener(_onNewPasswordConfirmChanged);
    super.initState();
  }

  void _onNewPasswordChanged() {
    _bloc.add(
      NewPasswordChanged(password: _passwordController.text),
    );
  }

  void _onNewPasswordConfirmChanged() {
    _bloc.add(
      NewPasswordConfirmChanged(
          password: _passwordController.text,
          passwordConfirm: _passwordConfirmController.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: _bloc,
        child: BlocConsumer<NewPasswordBloc, NewPasswordState>(
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
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    super.dispose();
  }

  void _blocListener(BuildContext context, NewPasswordState state) {
    if (state is NewPasswordSuccess) {
      Fluttertoast.showToast(
        msg: "Pasword changed successfully",
        backgroundColor: Colors.grey[800],
        textColor: Colors.white,
      );
      AutoRouter.of(context).pop(password);
    } else if (state is NewPasswordFailure) {
      Fluttertoast.showToast(
        msg: state.error.toString(),
        backgroundColor: Colors.grey[800],
        textColor: Colors.white,
      );
    }
  }

  Widget _buildContent(BuildContext context, NewPasswordState state) {
    final String forgotPassword =
        AppLocalizations.of(context).translate("auth:new_password");
    final String desc =
        AppLocalizations.of(context).translate("auth:new_password_desc");
    final headingStyle = Theme.of(context).textTheme.headline6.copyWith(
          fontSize: 20,
          color: Colors.grey[700],
        );
    final descStyle = Theme.of(context).textTheme.bodyText2.copyWith(
          color: Colors.grey[500],
        );

    return SizedBox(
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
            controller: _passwordController,
            // enabled: isEnabled,
            label: 'New Password',
            obscureText: true,
            maxLines: 1,
            validator: (text) {
              if (text.isEmpty) return null;
              return !state.isPasswordValid ? 'Invalid Password' : null;
            },
          ),
          const SizedBox(height: AppInsets.xl),
          BaseFormInput(
            controller: _passwordConfirmController,
            // enabled: isEnabled,
            label: 'Confirm New Password',
            obscureText: true,
            maxLines: 1,
            validator: (text) {
              if (text.isEmpty) return null;
              return !state.isPasswordConfirmValid
                  ? 'Invalid Password Confirm'
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
      password = _passwordController.text;
      _bloc.add(NewPasswordRequestStarted(
        password: password,
        query: widget.params,
      ));
    }
  }
}
