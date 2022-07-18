import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:worknetwork/core/config_reader/config_reader.dart';
import 'package:worknetwork/core/push_notfications/models/push_notification_data/push_notification_data.dart';
import 'package:worknetwork/core/widgets/root_app.dart';
import 'package:worknetwork/core/widgets/screens/home_screen/home_screen.dart';
import 'package:worknetwork/features/chat/data/models/chat_message_model.dart';
import 'package:worknetwork/routes.gr.dart';

final pushNotificationsProvider = Provider(
  (ref) {
    return PushNotificationsImpl(ref.read);
  },
);

abstract class PushNotifications {
  Future<void> initSdk();
  Future<String> getSubscriptionToken();
  Future<String?> getPushToken();
  Future<void> setUserIdentifier(String phone);
  void setEventHandlers();
  void handleNotificationsPressed(OSNotificationOpenedResult result);
  void subscriptionsChangeHandler(OSSubscriptionStateChanges changes);
  void handleNotificationReceived(OSNotification notification);
}

class PushNotificationsImpl implements PushNotifications {
  final Reader read;

  PushNotificationsImpl(this.read);

  @override
  Future<String> getSubscriptionToken() async {
    final Completer<String> _completer = Completer();
    final device = await OneSignal.shared.getDeviceState();
    final userId = device?.userId;
    if (userId == null) {
      OneSignal.shared.setSubscriptionObserver((changes) {
        if (changes.to.userId != null) {
          _completer.complete(changes.to.userId);
        }
      });
    } else {
      _completer.complete(userId);
    }
    return _completer.future;
  }

  @override
  Future<String?> getPushToken() async {
    final device = await OneSignal.shared.getDeviceState();

    return device?.pushToken;
  }

  @override
  void handleNotificationReceived(OSNotification notification) {
    // TODO: implement handleNotificationReceived
  }

  @override
  Future<void> handleNotificationsPressed(
    OSNotificationOpenedResult result,
  ) async {
    if (result.notification.additionalData == null) {
      return;
    }

    final objTyp = result.notification.additionalData?["obj_type"];
    final json = result.notification.additionalData;

    final PushType type = enumFromType(objTyp);
    final _navigatorKey = read(navigatorKeyProvider);

    if (type == PushType.chatMessage) {
      final message = ChatMessage.fromJson(json!);
      _navigatorKey.currentState?.pushNamed(
        ChatScreenRoute.name,
        arguments:
            ChatScreenRouteArgs(recieverId: message.senderId!, creatorId: 0),
      );
    } else if (type == PushType.conversation) {
      final ConversationNotificationData data =
          ConversationNotificationData.fromJson(json!);

      _navigatorKey.currentState?.pushNamed(
        ConversationScreenRoute.name,
        arguments: ConversationScreenRouteArgs(id: data.groupId as int),
      );
    } else if (type == PushType.upcomingMeeting) {
      if (_navigatorKey.currentWidget is! HomeScreen) {
        _navigatorKey.currentState?.pushNamed(HomeScreenRoute.name);
      }
    } else if (type == PushType.createConversation) {
      _navigatorKey.currentState?.pushNamed(
        HomeScreenRoute.name,
        arguments: const HomeScreenRouteArgs(tab: 1),
      );
    }
  }

  @override
  Future<void> initSdk() async {
    final _ = {
      OSiOSSettings.autoPrompt: false,
      OSiOSSettings.inAppLaunchUrl: false,
    };
    //TODO: iOS settings

    OneSignal.shared.setAppId(ConfigReader.getOneSignalAppId());

    // await OneSignal.shared.init(
    //   ,
    //   iOSSettings: settings,
    // );

    // await OneSignal.shared.setSubscription(true);

    final consent = await OneSignal.shared.requiresUserPrivacyConsent();
    if (consent) {
      OneSignal.shared.consentGranted(true);
    }

    // OneSignal.shared
    //     .setInFocusDisplayType(OSNotificationDisplayType.notification);

    // The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    await OneSignal.shared
        .promptUserForPushNotificationPermission(fallbackToSettings: true);
  }

  @override
  Future<void> setUserIdentifier(String phone) async {
    await OneSignal.shared.setExternalUserId(phone);
  }

  @override
  void subscriptionsChangeHandler(OSSubscriptionStateChanges changes) {
    // TODO: implement subscriptionsChangeHandler
  }

  @override
  void setEventHandlers() {
    OneSignal.shared.setSubscriptionObserver(subscriptionsChangeHandler);

    // OneSignal.shared.setNotificationReceivedHandler(handleNotificationReceived);

    OneSignal.shared.setNotificationOpenedHandler(handleNotificationsPressed);
  }
}
