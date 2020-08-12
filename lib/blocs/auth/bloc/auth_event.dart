part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthStarted extends AuthEvent {}

class AuthLoggedIn extends AuthEvent {
  final String token;
  final User user;

  const AuthLoggedIn({
    @required this.token,
    @required this.user,
  });

  @override
  List<Object> get props => [token, user];

  @override
  String toString() => 'Auth LoggedIn { token: $token }';
}

class AuthLoggedOut extends AuthEvent {}

class AuthConnectWebSocket extends AuthEvent {}
