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
import 'package:worknetwork/features/auth/presentation/screens/phone/phone_screen_state.dart';
import 'package:worknetwork/features/auth/presentation/screens/splash/splash_screen_state.dart';
import 'package:worknetwork/utils/analytics_helpers.dart';

final otpStateProvider = StateProvider((ref) => '');
final otpAPIProvider = StateNotifierProvider<OtpAPINotifier, ApiResult<User?>>(
  (ref) => OtpAPINotifier(ref.read),
);

class OtpAPINotifier extends StateNotifier<ApiResult<User?>> {
  Reader read;
  OtpAPINotifier(this.read) : super(ApiResult.data(null));

  Future<User?> submit() async {
    state = ApiResult.loading();

    final attributionProvider = read(attributionManagerProvider);
    final data = await attributionProvider.getAttributionData();

    final phone = read(phoneStateProvider);
    final otp = read(otpStateProvider);
    final response =
        await read(authRepositoryProvider).verifyOtp(phone, otp, data);

    return response.fold((failure) {
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
      return;
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
      read(authTokenProvider.notifier).state = user.token;

      state = ApiResult.data(user);
      return user;
    });
  }
}
