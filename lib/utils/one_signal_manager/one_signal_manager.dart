import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:worknetwork/constants/app_constants.dart';

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
    // TODO: implement initState
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

    OneSignal.shared.setSubscriptionObserver(_onSubscriptionChangeHandler);
    OneSignal.shared
        .setNotificationReceivedHandler(_handleNotificationReceived);
  }

  // will be called whenever the subscription changes
  //(ie. user gets registered with OneSignal and gets a user ID)
  void _onSubscriptionChangeHandler(OSSubscriptionStateChanges changes) {}

  // will be called whenever the notifcation is recieved
  // Returns  => [OSNotification] notification
  void _handleNotificationReceived(OSNotification notification) {}
}
