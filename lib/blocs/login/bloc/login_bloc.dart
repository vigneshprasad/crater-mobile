import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:worknetwork/blocs/auth/bloc/auth_bloc.dart';
import 'package:worknetwork/blocs/auth/repo/auth_repository.dart';
import 'package:worknetwork/utils/validators.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _authRepositry = AuthRepository();
  final AuthBloc _authBloc;

  LoginBloc(this._authBloc) : super(LoginState.initial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginEmailChanged) {
      yield* _mapLoginEmailChangedToState(event.email);
    } else if (event is LoginPasswordChanged) {
      yield* _mapLoginPasswordChangedToState(event.password);
    } else if (event is LoginWithGooglePressed) {
      yield* _mapLoginWithGooglePressedToState();
    } else if (event is LoginWithEmailPressed) {
      yield* _mapLoginWithCredentialsPressedToState(
        email: event.email,
        password: event.password,
      );
    }
  }

  Stream<LoginState> _mapLoginEmailChangedToState(String email) async* {
    yield state.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<LoginState> _mapLoginPasswordChangedToState(String password) async* {
    yield state.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }

  Stream<LoginState> _mapLoginWithGooglePressedToState() async* {
    try {
      final GoogleSignInAuthentication authUser =
          await _authRepositry.signInWithGoogle();
      yield LoginState.loading();
      final response =
          await _authRepositry.authWithGoogle(authUser.accessToken);
      _authBloc.add(AuthLoggedIn(
        token: response.token,
        user: response.user,
      ));
      yield LoginState.success();
    } catch (_) {
      yield LoginState.failure();
    }
  }

  Stream<LoginState> _mapLoginWithCredentialsPressedToState({
    String email,
    String password,
  }) async* {
    yield LoginState.loading();
    try {
      final response =
          await _authRepositry.loginEmail(email: email, password: password);
      _authBloc.add(AuthLoggedIn(
        token: response.token,
        user: response.user,
      ));
      yield LoginState.success();
    } catch (_) {
      yield LoginState.failure();
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
