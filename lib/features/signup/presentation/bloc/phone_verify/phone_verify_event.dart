part of 'phone_verify_bloc.dart';

abstract class PhoneVerifyEvent extends Equatable {
  const PhoneVerifyEvent();

  @override
  List<Object> get props => [];
}

class PostNewPhoneNumberRequestStarted extends PhoneVerifyEvent {
  final String phoneNumber;

  const PostNewPhoneNumberRequestStarted({
    required this.phoneNumber,
  });

  @override
  List<Object> get props => [phoneNumber];
}

class PostSmsCodeRequestStarted extends PhoneVerifyEvent {
  final String phoneNumber;
  final String smsCode;

  const PostSmsCodeRequestStarted({
    required this.smsCode,
    required this.phoneNumber,
  });

  @override
  List<Object> get props => [smsCode, phoneNumber];
}
