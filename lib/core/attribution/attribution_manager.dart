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

  Future<bool> logEvent(String eventName, Map<dynamic, dynamic> eventDetails);
}

class AttributionManagerImpl implements AttributionManager {
  AppsflyerSdk? _appsflyerSdk;

  @override
  Future<void> intializeSdk() async {
    final sdk = await _initializeAppsFlyerSdk();
    _appsflyerSdk = sdk;
  }

  Future<AppsflyerSdk> _initializeAppsFlyerSdk() async {
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

    return appsflyerSdk;
  }

  Future<String> _getApplicationId() async {
    if (Platform.isAndroid) {
      final info = await PackageInfo.fromPlatform();
      return info.packageName;
    } else {
      return "1504844194";
    }
  }

  @override
  Future<bool> logEvent(String eventName, Map eventDetails) async {
    _appsflyerSdk ??= await _initializeAppsFlyerSdk();

    try {
      return await _appsflyerSdk!.logEvent(eventName, eventDetails);
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
