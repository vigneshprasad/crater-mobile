import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intercom_flutter/intercom_flutter.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../config_reader/config_reader.dart';

final intercomProvider = Provider((_) => IntercomProvider());

class IntercomProvider {
  Future<void> initSdk() async {
    await Intercom.initialize(
      't37hxxeu',
      iosApiKey: ConfigReader.getIntercomiOSEnvKey(),
      androidApiKey: ConfigReader.getIntercomAndroidEnvKey(),
    );
  }

  Future<void> show(String email) async {
    await Intercom.registerIdentifiedUser(email: email);
    final device = await OneSignal.shared.getDeviceState();
    final token = device?.pushToken;
    if (token != null) {
      await Intercom.sendTokenToIntercom(token);
    }
    await Intercom.displayMessenger();
  }
}
