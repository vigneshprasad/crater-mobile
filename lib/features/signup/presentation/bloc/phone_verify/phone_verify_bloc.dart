import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/analytics/analytics.dart';
import '../../../../../core/analytics/anlytics_events.dart';
import '../../../../../core/error/failures.dart';
import '../../../domain/usecase/post_new_phone_number_usecase.dart';
import '../../../domain/usecase/post_sms_code_usecase.dart';

part 'phone_verify_event.dart';
part 'phone_verify_state.dart';

class PhoneVerifyBloc extends Bloc<PhoneVerifyEvent, PhoneVerifyState> {
  final UCPostNewPhoneNumber postNewPhoneNumber;
  final UCPostSmsCode postSmsCode;
  final Analytics analytics;

  PhoneVerifyBloc({
    required this.postNewPhoneNumber,
    required this.postSmsCode,
    required this.analytics,
  }) : super(const PhoneVerifyInitial());

  @override
  Stream<PhoneVerifyState> mapEventToState(
    PhoneVerifyEvent event,
  ) async* {
    if (event is PostNewPhoneNumberRequestStarted) {
      yield* _mapPostPhoneNumberToState(event);
    } else if (event is PostSmsCodeRequestStarted) {
      yield* _mapPostSmsCodeToState(event);
    }
  }

  Stream<PhoneVerifyState> _mapPostPhoneNumberToState(
      PostNewPhoneNumberRequestStarted event) async* {
    yield const PhoneVerifyRequestLoading();
    final sentOrError = await postNewPhoneNumber(
        PostNewPhoneNumberParams(phoneNumber: event.phoneNumber));

    yield sentOrError.fold(
      (failure) => PhoneVerifyRequestError(error: failure),
      (response) => PhoneNumberPostRequestLoaded(status: response.status),
    );
  }

  Stream<PhoneVerifyState> _mapPostSmsCodeToState(
      PostSmsCodeRequestStarted event) async* {
    yield const PhoneVerifyRequestLoading();
    final sentOrError =
        await postSmsCode(PostSmsCodeParams(smsCode: event.smsCode));

    yield sentOrError.fold(
      (failure) => PhoneVerifyRequestError(error: failure),
      (response) {
        analytics.identify(properties: {
          "phone_number": event.phoneNumber,
          "phone_number_verified": true,
        });
        analytics.trackEvent(
          eventName: AnalyticsEvents.signUpPhoneVerified,
          properties: {
            "phone_number": event.phoneNumber,
          },
        );
        return PhoneSmsCodeRequestLoaded(status: response.status);
      },
    );
  }
}
