import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intercom_flutter/intercom_flutter.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../config_reader/config_reader.dart';

final intercomProvider = Provider((_) => IntercomProvider());

class IntercomProvider {
  Future<void> initSdk() async {
    final status = await Intercom.initialize(
      't37hxxeu',
      iosApiKey: ConfigReader.getIntercomiOSEnvKey(),
      androidApiKey: ConfigReader.getIntercomAndroidEnvKey(),
    );
    debugPrint(status.toString());
  }

  Future<void> show(String email) async {
    await Intercom.registerIdentifiedUser(email: email);
    final sub = await OneSignal.shared.getPermissionSubscriptionState();
    final token = sub.subscriptionStatus.pushToken;
    if (token != null) {
      await Intercom.sendTokenToIntercom(token);
    }
    await Intercom.displayMessenger();
  }
}
