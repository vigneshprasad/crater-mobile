import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/features/auth/domain/entity/user_entity.dart';

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

  Future<void> setUserData(User user) async {
    await UserLeapFlutter.setEmailAddress(user.email!);
    await UserLeapFlutter.setUserIdentifier(user.pk!);
  }
}
