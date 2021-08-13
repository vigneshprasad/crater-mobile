import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/validators/validators.dart';
import '../../../domain/usecase/post_password_reset_usecase.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final UCPostPasswordReset passwordReset;
  ForgotPasswordBloc({
    required this.passwordReset,
  }) : super(const ForgotPasswordInitial());

  @override
  Stream<ForgotPasswordState> mapEventToState(
    ForgotPasswordEvent event,
  ) async* {
    if (event is ForgotPasswordRequestStarted) {
      yield* _mapForgotPasswordRequestToState(event);
    } else if (event is ForgotPasswordEmailChanged) {
      yield* _mapEmailChangeToState(event);
    }
  }

  Stream<ForgotPasswordState> _mapForgotPasswordRequestToState(
      ForgotPasswordRequestStarted event) async* {
    yield state.loading();

    final responseOrerror =
        await passwordReset(PostPasswordResetParams(email: event.email));

    yield responseOrerror.fold(
      (error) => ForgotPasswordFailure(error: error),
      (response) => ForgotPasswordSuccess(response: response),
    );
  }

  Stream<ForgotPasswordState> _mapEmailChangeToState(
      ForgotPasswordEmailChanged event) async* {
    yield state.update(isEmailValid: Validators.isValidEmail(event.email));
  }
}
