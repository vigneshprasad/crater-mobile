part of 'new_password_bloc.dart';

abstract class NewPasswordEvent extends Equatable {
  const NewPasswordEvent();
}

class NewPasswordRequestStarted extends NewPasswordEvent {
  final String password;
  final String query;

  const NewPasswordRequestStarted({
    @required this.password,
    @required this.query,
  });

  @override
  List<Object> get props => [password, query];
}

class NewPasswordChanged extends NewPasswordEvent {
  final String password;

  const NewPasswordChanged({this.password});

  @override
  List<Object> get props => [password];
}

class NewPasswordConfirmChanged extends NewPasswordEvent {
  final String password;
  final String passwordConfirm;

  const NewPasswordConfirmChanged({this.password, this.passwordConfirm});

  @override
  List<Object> get props => [password, passwordConfirm];
}
