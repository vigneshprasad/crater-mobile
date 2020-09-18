part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthStarted extends AuthEvent {}

class AuthLoggedIn extends AuthEvent {
  final User user;

  const AuthLoggedIn({
    @required this.user,
  });

  @override
  List<Object> get props => [user];
}

class AuthLoggedOut extends AuthEvent {}

class AuthLoginEmailPressed extends AuthEvent {
  final String email;
  final String password;

  const AuthLoginEmailPressed({
    @required this.email,
    @required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class AuthRegisterEmailPressed extends AuthEvent {
  final String name;
  final String email;
  final String password;

  const AuthRegisterEmailPressed({
    @required this.name,
    @required this.email,
    @required this.password,
  });

  @override
  List<Object> get props => [name, email, password];
}

class AuthEmailChanged extends AuthEvent {
  final String email;

  const AuthEmailChanged({
    this.email,
  });

  @override
  List<Object> get props => [email];
}

class AuthPaswordChanged extends AuthEvent {
  final String password;

  const AuthPaswordChanged({
    this.password,
  });

  @override
  List<Object> get props => [password];
}

class AuthSocialPressed extends AuthEvent {
  final SocialAuthProviders provider;

  const AuthSocialPressed({
    this.provider,
  });

  @override
  List<Object> get props => [provider];
}

class AuthUserUpdateRecieved extends AuthEvent {
  final User user;

  const AuthUserUpdateRecieved({
    @required this.user,
  });

  @override
  List<Object> get props => [user];
}

class AuthUserProfileUpdateRecieved extends AuthEvent {
  final UserProfile profile;

  const AuthUserProfileUpdateRecieved({
    this.profile,
  });

  @override
  List<Object> get props => [profile];
}
