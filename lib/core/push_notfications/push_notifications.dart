import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:worknetwork/constants/app_constants.dart';
import 'package:worknetwork/features/chat/data/models/chat_message_model.dart';

import '../../routes.gr.dart';

abstract class PushNotifications {
  Future<void> initSdk();
  Future<String> getSubscribtionsToken();
  Future<String> getPushToken();
  void handleNotificationsPressed(OSNotificationOpenedResult result);
  void subscriptionsChangeHandler(OSSubscriptionStateChanges changes);
  void handleNotificationReceived(OSNotification notification);
}

class PushNotificationsImpl implements PushNotifications {
  @override
  Future<String> getSubscribtionsToken() async {
    final sub = await OneSignal.shared.getPermissionSubscriptionState();
    return sub.subscriptionStatus.userId;
  }

  @override
  Future<String> getPushToken() async {
    final sub = await OneSignal.shared.getPermissionSubscriptionState();
    return sub.subscriptionStatus.pushToken;
  }

  @override
  void handleNotificationReceived(OSNotification notification) {
    // TODO: implement handleNotificationReceived
  }

  @override
  void handleNotificationsPressed(OSNotificationOpenedResult result) {
    final objTyp = result.notification.payload.additionalData["obj_type"];
    final json = result.notification.payload.additionalData;

    if (objTyp == "message") {
      final message = ChatMessageModel.fromJson(json);
      final _navigatorKey =
          KiwiContainer().resolve<GlobalKey<NavigatorState>>();
      _navigatorKey.currentState.pushNamed(Routes.chatScreen,
          arguments: ChatScreenArguments(recieverId: message.senderId));
    }
  }

  @override
  Future<void> initSdk() async {
    final settings = {
      OSiOSSettings.autoPrompt: false,
      OSiOSSettings.inAppLaunchUrl: false,
    };

    await OneSignal.shared.init(
      AppConstants.oneSignalAppId,
      iOSSettings: settings,
    );

    await OneSignal.shared.setSubscription(true);

    final consent = await OneSignal.shared.requiresUserPrivacyConsent();
    if (consent) {
      OneSignal.shared.consentGranted(true);
    }

    // The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    await OneSignal.shared
        .promptUserForPushNotificationPermission(fallbackToSettings: true);

    OneSignal.shared.setSubscriptionObserver(subscriptionsChangeHandler);

    OneSignal.shared.setNotificationReceivedHandler(handleNotificationReceived);

    OneSignal.shared.setNotificationOpenedHandler(handleNotificationsPressed);
    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);
  }

  @override
  void subscriptionsChangeHandler(OSSubscriptionStateChanges changes) {
    // TODO: implement subscriptionsChangeHandler
  }
}
