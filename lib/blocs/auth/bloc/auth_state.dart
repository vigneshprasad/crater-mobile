part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  final User user;
  final String token;
  final bool isAuth;

  const AuthState({
    this.user,
    this.token,
    this.isAuth,
  });

  @override
  List<Object> get props => [user, token, isAuth];
}

class AuthStateInitial extends AuthState {
  const AuthStateInitial() : super(isAuth: false);
}

class AuthStateSuccess extends AuthState {
  const AuthStateSuccess({
    User user,
    String token,
  }) : super(
          user: user,
          token: token,
          isAuth: true,
        );
}

class AuthStateFailure extends AuthState {
  const AuthStateFailure() : super(isAuth: false);
}
