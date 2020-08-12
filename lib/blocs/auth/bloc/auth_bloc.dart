import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:worknetwork/blocs/auth/repo/auth_repository.dart';
import 'package:worknetwork/models/user/user_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository = AuthRepository();

  AuthBloc() : super(const AuthStateInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AuthStarted) {
      final token = await _authRepository.hasToken();
      final user = await _authRepository.hasUser();

      if (token.isNotEmpty && user != null) {
        yield AuthStateSuccess(user: user, token: token);
      } else {
        yield const AuthStateFailure();
      }
    }

    if (event is AuthLoggedIn) {
      await _authRepository.presistToken(event.token);
      await _authRepository.persistUser(event.user);
      yield AuthStateSuccess(user: event.user, token: event.token);
    }
  }

  @override
  Future<void> close() {
    _authRepository.dispose();
    return super.close();
  }
}
