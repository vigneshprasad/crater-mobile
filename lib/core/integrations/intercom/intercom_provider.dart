import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intercom_flutter/intercom_flutter.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:worknetwork/features/auth/presentation/bloc/auth_bloc.dart';

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

  Future<void> show(BuildContext context) async {
    final email = BlocProvider.of<AuthBloc>(context).state.user?.email;
    if (email != null) {
      await Intercom.registerIdentifiedUser(email: email);
    } else {
      await Intercom.registerUnidentifiedUser();
    }
    final device = await OneSignal.shared.getDeviceState();
    final token = device?.pushToken;
    if (token != null) {
      await Intercom.sendTokenToIntercom(token);
    }
    await Intercom.displayMessenger();
  }
}
