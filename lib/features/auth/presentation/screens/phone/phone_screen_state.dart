import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/api/integrations/devices_api_service.dart';
import 'package:worknetwork/core/analytics/analytics.dart';
import 'package:worknetwork/core/analytics/anlytics_events.dart';
import 'package:worknetwork/core/api_result/api_result.dart';
import 'package:worknetwork/core/attribution/attribution_manager.dart';
import 'package:worknetwork/core/error/exceptions.dart';
import 'package:worknetwork/core/error/failures/failures.dart';
import 'package:worknetwork/core/features/socket_io/socket_io_manager.dart';
import 'package:worknetwork/core/push_notfications/push_notifications.dart';
import 'package:worknetwork/features/auth/data/repository/auth_repository_impl.dart';
import 'package:worknetwork/features/auth/domain/entity/user_entity.dart';
import 'package:worknetwork/features/auth/domain/entity/user_profile_entity.dart';
import 'package:worknetwork/features/auth/presentation/screens/splash/splash_screen_state.dart';
import 'package:worknetwork/utils/analytics_helpers.dart';

final phoneStateProvider = StateProvider((ref) => '');

final otpStateProvider = StateProvider((ref) => '');

final phoneAPIProvider =
    StateNotifierProvider<PhoneAPINotifier, ApiResult<bool>>(
  (ref) => PhoneAPINotifier(ref.read),
);

final otpAPIProvider = StateNotifierProvider<OtpAPINotifier, ApiResult<User?>>(
  (ref) => OtpAPINotifier(ref.read),
);

enum PhoneScreenStatus {
  initial,
  phoneSubmitting,
  otpSent,
  phoneError,
  otpSubmitting,
  otpError,
  success,
}

final phoneScreenStateProvider = StateProvider<PhoneScreenStatus>(
  (ref) {
    final phoneNotifier = ref.watch(phoneAPIProvider);
    final otpNotifier = ref.watch(otpAPIProvider);

    final phoneResult = phoneNotifier.map(
      loading: (value) => PhoneScreenStatus.phoneSubmitting,
      data: (result) =>
          result.data ? PhoneScreenStatus.otpSent : PhoneScreenStatus.initial,
      error: (error) => PhoneScreenStatus.phoneError,
    );

    switch (phoneResult) {
      case PhoneScreenStatus.initial:
        return phoneResult;
      case PhoneScreenStatus.phoneSubmitting:
        return phoneResult;
      case PhoneScreenStatus.phoneError:
        return phoneResult;
      default:
    }

    final otpResult = otpNotifier.map(
      loading: (value) => PhoneScreenStatus.otpSubmitting,
      data: (value) =>
          value.data != null ? PhoneScreenStatus.success : phoneResult,
      error: (value) => PhoneScreenStatus.otpError,
    );

    return otpResult;
  },
);

class PhoneAPINotifier extends StateNotifier<ApiResult<bool>> {
  Reader read;
  PhoneAPINotifier(this.read) : super(ApiResult.data(false));

  Future<void> submit() async {
    state = ApiResult.loading();

    final phone = read(phoneStateProvider);
    final response = await read(authRepositoryProvider).sendOtp(phone);

    response.fold((failure) {
      final exception = failure.message as ServerException?;
      final errorDetail = exception?.message as String?;
      Map? map;
      try {
        map = jsonDecode(errorDetail ?? '') as Map?;
      } catch (e) {
        debugPrint(e.toString());
      }
      final message = (map?['error_message'] as String?) ??
          ((map?['username'] as List?)?.first as String?) ??
          failure.toString();
      final error = ServerFailure(message);
      state = ApiResult.error(error);
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey[700],
        textColor: Colors.white,
        fontSize: 14,
      );
    }, (r) {
      state = ApiResult.data(true);
    });
  }
}

class OtpAPINotifier extends StateNotifier<ApiResult<User?>> {
  Reader read;
  OtpAPINotifier(this.read) : super(ApiResult.data(null));

  Future<void> submit() async {
    state = ApiResult.loading();

    final attributionProvider = read(attributionManagerProvider);
    final data = await attributionProvider.getAttributionData();

    final phone = read(phoneStateProvider);
    final otp = read(otpStateProvider);
    final response =
        await read(authRepositoryProvider).verifyOtp(phone, otp, data);

    response.fold((failure) {
      final exception = failure.message as ServerException?;
      final errorDetail = exception?.message as String?;
      Map? map;
      try {
        map = jsonDecode(errorDetail ?? '') as Map?;
      } catch (e) {
        debugPrint(e.toString());
      }
      final message = (map?['error_message'] as String?) ??
          ((map?['otp'] as List?)?.first as String?) ??
          failure.toString();
      final error = ServerFailure(message);
      state = ApiResult.error(error);
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey[700],
        textColor: Colors.white,
        fontSize: 14,
      );
    }, (user) async {
      final profileResponse =
          await read(authRepositoryProvider).getUserProfile();
      final _ = profileResponse.getOrElse(() => UserProfile());

      final socketIOManager = read(userPermissionNotifierProvider.notifier);
      await socketIOManager.listenPermissions();

      final analytics = read(analyticsProvider);
      analytics.initSdk();
      analytics.identify(properties: getUserTraitsFromModel(user));
      await analytics.trackEvent(
        eventName: AnalyticsEvents.login,
        properties: {
          "email": user.email,
          "intent": user.intent,
        },
      );

      final pushNotifications = read(pushNotificationsProvider);
      await pushNotifications.setUserIdentifier(phone);

      final osId = await pushNotifications.getSubscriptionToken();
      debugPrint(osId);
      final deviceAPI = read(devicesApiServiceProvider);
      deviceAPI.registerDevice({
        'os_id': osId,
        'user': user.pk,
      }).then((response) {
        debugPrint(response.toString());
      });

      read(authStateProvider.notifier).setUser(user);

      state = ApiResult.data(user);
    });
  }
}
