part of 'phone_verify_bloc.dart';

abstract class PhoneVerifyState extends Equatable {
  final bool loading;
  final Failure error;

  const PhoneVerifyState({
    this.loading,
    this.error,
  });

  @override
  List<Object> get props => [loading, error];
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
    @required Failure error,
  }) : super(
          loading: false,
          error: error,
        );
}

class PhoneNumberPostRequestLoaded extends PhoneVerifyState {
  final String status;
  const PhoneNumberPostRequestLoaded({
    this.status,
  }) : super(
          loading: false,
          error: null,
        );

  @override
  List<Object> get props => [loading, error, status];
}

class PhoneSmsCodeRequestLoaded extends PhoneVerifyState {
  final String status;
  const PhoneSmsCodeRequestLoaded({
    this.status,
  }) : super(
          loading: false,
          error: null,
        );

  @override
  List<Object> get props => [loading, error, status];
}
