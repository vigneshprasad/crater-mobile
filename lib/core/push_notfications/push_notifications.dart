import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:worknetwork/features/conversations/presentation/screens/create_conversation_screen/create_conversation_state.dart';

import '../../features/chat/data/models/chat_message_model.dart';
import '../../features/conversations/domain/entity/topic_entity/topic_entity.dart';
import '../../features/conversations/presentation/screens/create_conversation_sheet/create_conversation_sheet.dart';
import '../../routes.gr.dart';
import '../config_reader/config_reader.dart';
import '../widgets/screens/home_screen/home_screen.dart';
import 'models/push_notification_data/push_notification_data.dart';

abstract class PushNotifications {
  Future<void> initSdk();
  Future<String> getSubscriptionToken();
  Future<String> getPushToken();
  void setEventHandlers();
  void handleNotificationsPressed(OSNotificationOpenedResult result);
  void subscriptionsChangeHandler(OSSubscriptionStateChanges changes);
  void handleNotificationReceived(OSNotification notification);
}

class PushNotificationsImpl implements PushNotifications {
  @override
  Future<String> getSubscriptionToken() async {
    final Completer<String> _completer = Completer();
    final sub = await OneSignal.shared.getPermissionSubscriptionState();
    final userId = sub.subscriptionStatus.userId;
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
    if (result.notification.payload.additionalData == null) {
      return;
    }

    final objTyp = result.notification.payload.additionalData["obj_type"];
    final json = result.notification.payload.additionalData;

    final PushType type = enumFromType(objTyp);
    final _navigatorKey = KiwiContainer().resolve<GlobalKey<NavigatorState>>();

    if (type == PushType.chatMessage) {
      final message = ChatMessageModel.fromJson(json);
      _navigatorKey.currentState.pushNamed(Routes.chatScreen,
          arguments: ChatScreenArguments(recieverId: message.senderId));
    } else if (type == PushType.conversation) {
      final data = ConversationNotificationData.fromJson(json);

      _navigatorKey.currentState
          .pushNamed(Routes.conversationScreen(id: data.groupId));
    } else if (type == PushType.upcomingMeeting) {
      if (_navigatorKey.currentWidget is! HomeScreen) {
        _navigatorKey.currentState.pushNamed(Routes.homeScreen(tab: 0));
      }
    } else if (type == PushType.createConversation) {
      _navigatorKey.currentState.push(CreateConversationSheet()).then(
        (value) {
          if (value != null && value is Topic) {
            ExtendedNavigator.root.pushCreateConversationScreen(
                topic: value, type: ConversationType.curated);
          }
        },
      );
    }
  }

  @override
  Future<void> initSdk() async {
    final settings = {
      OSiOSSettings.autoPrompt: false,
      OSiOSSettings.inAppLaunchUrl: false,
    };

    await OneSignal.shared.init(
      ConfigReader.getOneSignalAppId(),
      iOSSettings: settings,
    );

    await OneSignal.shared.setSubscription(true);

    final consent = await OneSignal.shared.requiresUserPrivacyConsent();
    if (consent) {
      OneSignal.shared.consentGranted(true);
    }

    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);

    // The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    await OneSignal.shared
        .promptUserForPushNotificationPermission(fallbackToSettings: true);
  }

  @override
  void subscriptionsChangeHandler(OSSubscriptionStateChanges changes) {
    // TODO: implement subscriptionsChangeHandler
  }

  @override
  void setEventHandlers() {
    OneSignal.shared.setSubscriptionObserver(subscriptionsChangeHandler);

    OneSignal.shared.setNotificationReceivedHandler(handleNotificationReceived);

    OneSignal.shared.setNotificationOpenedHandler(handleNotificationsPressed);
  }
}
