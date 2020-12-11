part of 'forgot_password_bloc.dart';

@immutable
class ForgotPasswordState extends Equatable {
  final String response;
  final bool isEmailValid;
  final Failure error;
  final bool isSubmitting;

  const ForgotPasswordState({
    this.response,
    this.isEmailValid,
    this.error,
    this.isSubmitting,
  });

  ForgotPasswordState copyWith({
    String response,
    bool isEmailValid,
    Failure error,
    bool isSubmitting,
  }) {
    return ForgotPasswordState(
      response: response ?? this.response,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      error: error ?? this.error,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }

  ForgotPasswordState loading() {
    return copyWith(
      isSubmitting: true,
    );
  }

  ForgotPasswordState update({
    @required bool isEmailValid,
  }) {
    return copyWith(
      isEmailValid: isEmailValid,
    );
  }

  @override
  List<Object> get props => [
        response,
        isEmailValid,
        error,
        isSubmitting,
      ];
}

class ForgotPasswordInitial extends ForgotPasswordState {
  const ForgotPasswordInitial()
      : super(
          response: null,
          isEmailValid: false,
          error: null,
          isSubmitting: false,
        );
}

class ForgotPasswordSuccess extends ForgotPasswordState {
  const ForgotPasswordSuccess({
    @required final String response,
  }) : super(
          response: response,
          isEmailValid: true,
          error: null,
          isSubmitting: false,
        );
}

class ForgotPasswordFailure extends ForgotPasswordState {
  const ForgotPasswordFailure({
    @required Failure error,
  }) : super(
          response: null,
          isEmailValid: true,
          error: error,
          isSubmitting: false,
        );
}
