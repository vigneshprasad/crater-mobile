import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/validators/validators.dart';
import '../../../domain/usecase/post_new_password_usecase.dart';

part 'new_password_event.dart';
part 'new_password_state.dart';

class NewPasswordBloc extends Bloc<NewPasswordEvent, NewPasswordState> {
  final UCPostNewPassword postNewPassword;
  NewPasswordBloc({
    @required this.postNewPassword,
  })  : assert(postNewPassword != null),
        super(const NewPasswordInitial());

  @override
  Stream<NewPasswordState> mapEventToState(
    NewPasswordEvent event,
  ) async* {
    if (event is NewPasswordRequestStarted) {
      yield* _mapForgotPasswordRequestToState(event);
    } else if (event is NewPasswordChanged) {
      yield* _mapPasswordChangeToState(event);
    } else if (event is NewPasswordConfirmChanged) {
      yield* _mapPasswordConfirmChangeToState(event);
    }
  }

  Stream<NewPasswordState> _mapForgotPasswordRequestToState(
      NewPasswordRequestStarted event) async* {
    yield state.loading();

    final Map<String, String> body = Map.from(
        Uri.parse('http://worknetwork.in/?${event.query}').queryParameters);

    body['new_password'] = event.password;
    final responseOrerror =
        await postNewPassword(PostNewPasswordParams(body: body));

    yield responseOrerror.fold(
      (error) => NewPasswordFailure(error: error),
      (response) => NewPasswordSuccess(response: response),
    );
  }

  Stream<NewPasswordState> _mapPasswordChangeToState(
      NewPasswordChanged event) async* {
    yield state.update(
        isPasswordValid: Validators.isValidPassword(event.password),
        isPasswordConfirmValid: true);
  }

  Stream<NewPasswordState> _mapPasswordConfirmChangeToState(
      NewPasswordConfirmChanged event) async* {
    yield state.update(
        isPasswordValid: Validators.isValidPassword(event.password),
        isPasswordConfirmValid: event.password == event.passwordConfirm);
  }
}
