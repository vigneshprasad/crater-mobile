part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();
}

class ForgotPasswordRequestStarted extends ForgotPasswordEvent {
  final String email;

  const ForgotPasswordRequestStarted({
    @required this.email,
  });

  @override
  List<Object> get props => [
        email,
      ];
}

class ForgotPasswordEmailChanged extends ForgotPasswordEvent {
  final String email;

  const ForgotPasswordEmailChanged({
    this.email,
  });

  @override
  List<Object> get props => [email];
}
