part of 'auth_bloc.dart';

@immutable
class AuthState extends Equatable {
  final User user;
  final bool isAuth;
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isFailure;

  bool get isFormValid => isEmailValid && isPasswordValid;

  const AuthState({
    this.user,
    this.isAuth,
    this.isEmailValid,
    this.isPasswordValid,
    this.isSubmitting,
    this.isFailure,
  });

  @override
  List<Object> get props => [
        user,
        isAuth,
        isEmailValid,
        isPasswordValid,
        isSubmitting,
        isFailure,
      ];

  AuthState loading() {
    return copyWith(
      isAuth: false,
      isSubmitting: true,
      isFailure: false,
    );
  }

  AuthState update({
    bool isEmailValid,
    bool isPasswordValid,
  }) {
    return copyWith(
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
      isSubmitting: false,
      isFailure: false,
    );
  }

  AuthState copyWith({
    User user,
    bool isAuth,
    bool isEmailValid,
    bool isPasswordValid,
    bool isSubmitting,
    bool isFailure,
  }) {
    return AuthState(
      user: user ?? this.user,
      isAuth: isAuth ?? this.isAuth,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isFailure: isFailure ?? this.isFailure,
    );
  }
}

class AuthStateInitial extends AuthState {
  const AuthStateInitial()
      : super(
          user: null,
          isAuth: false,
          isEmailValid: true,
          isPasswordValid: true,
          isSubmitting: false,
          isFailure: false,
        );
}

class AuthStateSuccess extends AuthState {
  const AuthStateSuccess({
    @required User user,
  }) : super(
          user: user,
          isAuth: false,
          isEmailValid: true,
          isPasswordValid: true,
          isSubmitting: false,
          isFailure: false,
        );
}

class AuthStateFailure extends AuthState {
  const AuthStateFailure()
      : super(
          user: null,
          isSubmitting: false,
          isEmailValid: true,
          isPasswordValid: true,
          isAuth: false,
          isFailure: true,
        );

  @override
  List<Object> get props => [
        user,
        isAuth,
        isEmailValid,
        isPasswordValid,
        isSubmitting,
        isFailure,
      ];
}

class AuthRequestFailure extends AuthState {
  final dynamic error;

  const AuthRequestFailure({@required this.error})
      : super(
          user: null,
          isSubmitting: false,
          isEmailValid: true,
          isPasswordValid: true,
          isAuth: false,
          isFailure: true,
        );

  @override
  List<Object> get props => [
        user,
        isAuth,
        isEmailValid,
        isPasswordValid,
        isSubmitting,
        isFailure,
      ];
}
