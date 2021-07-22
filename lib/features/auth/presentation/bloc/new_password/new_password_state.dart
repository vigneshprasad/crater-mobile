part of 'new_password_bloc.dart';

@immutable
class NewPasswordState extends Equatable {
  final String? response;
  final bool isPasswordValid;
  final bool isPasswordConfirmValid;
  final Failure? error;
  final bool isSubmitting;

  const NewPasswordState({
    this.response,
    required this.isPasswordValid,
    required this.isPasswordConfirmValid,
    this.error,
    required this.isSubmitting,
  });

  NewPasswordState copyWith({
    String? response,
    bool? isPasswordValid,
    bool? isPasswordConfirmValid,
    Failure? error,
    bool? isSubmitting,
  }) {
    return NewPasswordState(
      response: response ?? this.response,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isPasswordConfirmValid:
          isPasswordConfirmValid ?? this.isPasswordConfirmValid,
      error: error ?? this.error,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }

  NewPasswordState loading() {
    return copyWith(
      isSubmitting: true,
    );
  }

  NewPasswordState update({
    required bool isPasswordValid,
    required bool isPasswordConfirmValid,
  }) {
    return copyWith(
      isPasswordValid: isPasswordValid,
      isPasswordConfirmValid: isPasswordConfirmValid,
    );
  }

  @override
  List<Object> get props {
    final List<Object> temp = [
      isPasswordValid,
      isPasswordConfirmValid,
      isSubmitting,
    ];
    if (response != null) {
      temp.add(response!);
    }

    if (error != null) {
      temp.add(error!);
    }
    return temp;
  }
}

class NewPasswordInitial extends NewPasswordState {
  const NewPasswordInitial()
      : super(
          response: null,
          isPasswordValid: false,
          isPasswordConfirmValid: false,
          error: null,
          isSubmitting: false,
        );
}

class NewPasswordSuccess extends NewPasswordState {
  const NewPasswordSuccess({
    required final String response,
  }) : super(
          response: response,
          isPasswordValid: true,
          isPasswordConfirmValid: true,
          error: null,
          isSubmitting: false,
        );
}

class NewPasswordFailure extends NewPasswordState {
  const NewPasswordFailure({
    required Failure error,
  }) : super(
          response: null,
          isPasswordValid: true,
          isPasswordConfirmValid: true,
          error: error,
          isSubmitting: false,
        );
}
