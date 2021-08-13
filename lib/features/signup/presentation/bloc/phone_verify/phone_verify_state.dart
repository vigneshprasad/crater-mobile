part of 'phone_verify_bloc.dart';

abstract class PhoneVerifyState extends Equatable {
  final bool loading;
  final Failure? error;

  const PhoneVerifyState({
    required this.loading,
    this.error,
  });

  @override
  List<Object> get props => error != null ? [loading, error!] : [loading];
}

class PhoneVerifyInitial extends PhoneVerifyState {
  const PhoneVerifyInitial()
      : super(
          loading: false,
          error: null,
        );
}

class PhoneVerifyRequestLoading extends PhoneVerifyState {
  const PhoneVerifyRequestLoading()
      : super(
          loading: true,
          error: null,
        );
}

class PhoneVerifyRequestError extends PhoneVerifyState {
  const PhoneVerifyRequestError({
    required Failure error,
  }) : super(
          loading: false,
          error: error,
        );
}

class PhoneNumberPostRequestLoaded extends PhoneVerifyState {
  final String status;
  const PhoneNumberPostRequestLoaded({
    required this.status,
  }) : super(
          loading: false,
          error: null,
        );

  @override
  List<Object> get props =>
      error != null ? [loading, error!, status] : [loading, status];
}

class PhoneSmsCodeRequestLoaded extends PhoneVerifyState {
  final String status;
  const PhoneSmsCodeRequestLoaded({
    required this.status,
  }) : super(
          loading: false,
          error: null,
        );

  @override
  List<Object> get props =>
      error != null ? [loading, error!, status] : [loading, status];
}
