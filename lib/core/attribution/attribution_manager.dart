import 'dart:io';

import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info/package_info.dart';

import '../config_reader/config_reader.dart';

final attributionManagerProvider =
    Provider<AttributionManager>((_) => AttributionManagerImpl());

abstract class AttributionManager {
  /// Intialize all sdk and  set required event handlers
  Future<void> intializeSdk();
}

class AttributionManagerImpl implements AttributionManager {
  @override
  Future<void> intializeSdk() async {
    await _initializeAppsFlyerSdk();
  }

  Future<void> _initializeAppsFlyerSdk() async {
    final appId = await _getApplicationId();
    final isDebug = ConfigReader.getEnv() != "prod";

    final Map appsFlyerOptions = {
      "afDevKey": ConfigReader.getAppsFlyerDevkey(),
      "afAppId": appId,
      "isDebug": isDebug,
    };

    final AppsflyerSdk appsflyerSdk = AppsflyerSdk(appsFlyerOptions);

    await appsflyerSdk.initSdk(
      registerConversionDataCallback: true,
      registerOnAppOpenAttributionCallback: true,
      registerOnDeepLinkingCallback: true,
    );

    appsflyerSdk.onAppOpenAttribution((data) {
      print("asjkdnkajs djkasdaslkdmaklsdmalskdmlkamsdklasmdla");
      print(data.toString());
    });
  }

  Future<String> _getApplicationId() async {
    if (Platform.isAndroid) {
      final info = await PackageInfo.fromPlatform();
      return info.packageName;
    } else {
      return "1504844194";
    }
  }
}
