import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../channels/userleap/userleap_flutter.dart';
import '../../config_reader/config_reader.dart';

final userLeapProvider = Provider((_) => UserLeapProvider());

class UserLeapProvider {
  Future<void> initSdk() async {
    await UserLeapFlutter.configure(ConfigReader.getUserLeapEnvKey());
  }

  Future<void> track(String event) async {
    await UserLeapFlutter.track(event);
  }
}
