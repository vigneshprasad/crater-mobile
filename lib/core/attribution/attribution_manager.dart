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
    _setupAttribution();
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
      return await _appsflyerSdk?.logEvent(eventName, eventDetails) ?? false;
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  Future<void> _setupAttribution() async {
    _appsflyerSdk?.onInstallConversionData((res) {
      print("res: " + res.toString());
    });

    _appsflyerSdk?.onAppOpenAttribution((res) {
      print("res: " + res.toString());
    });

    _appsflyerSdk?.onDeepLinking((DeepLinkResult dp) {
      switch (dp.status) {
        case Status.FOUND:
          print(dp.deepLink?.toString());
          print("deep link value: ${dp.deepLink?.deepLinkValue}");
          break;
        case Status.NOT_FOUND:
          print("deep link not found");
          break;
        case Status.ERROR:
          print("deep link error: ${dp.error}");
          break;
        case Status.PARSE_ERROR:
          print("deep link status parsing error");
          break;
      }
    });
  }
}
