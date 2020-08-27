import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:worknetwork/constants/app_constants.dart';
import 'package:worknetwork/features/chat/data/models/chat_message_model.dart';

import '../../routes.gr.dart';

class OneSignalManager extends StatefulWidget {
  final Widget child;

  const OneSignalManager({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  _OneSignalManagerState createState() => _OneSignalManagerState();
}

class _OneSignalManagerState extends State<OneSignalManager> {
  @override
  void initState() {
    super.initState();
    initPlatformSdk();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  Future<void> initPlatformSdk() async {
    final settings = {
      OSiOSSettings.autoPrompt: false,
      OSiOSSettings.inAppLaunchUrl: false,
    };

    await OneSignal.shared.init(
      AppConstants.oneSignalAppId,
      iOSSettings: settings,
    );

    OneSignal.shared.setSubscription(true);
    OneSignal.shared.setSubscriptionObserver(_onSubscriptionChangeHandler);
    OneSignal.shared
        .setNotificationReceivedHandler(_handleNotificationReceived);

    OneSignal.shared.setNotificationOpenedHandler(_handleNotificationOpened);
    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);
  }

  /// will be called whenever a notification is opened/button pressed.
  /// Returns  => [OSNotificationOpenedResult] notification
  void _handleNotificationOpened(OSNotificationOpenedResult result) {
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

  /// will be called whenever the subscription changes
  /// Returns  => [OSSubscriptionStateChanges] notification
  void _onSubscriptionChangeHandler(OSSubscriptionStateChanges changes) {}

  /// Adds an observer function/callback that will get executed
  /// whenever a new OneSignal push notification is received on the device
  /// when app is in the foreground.
  /// Returns  => [OSNotification] notification
  void _handleNotificationReceived(OSNotification notification) {}
}
