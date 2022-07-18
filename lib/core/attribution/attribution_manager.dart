import 'dart:io';

import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:worknetwork/core/config_reader/config_reader.dart';

final attributionManagerProvider =
    Provider<AttributionManager>((_) => AttributionManagerImpl());

const appsFlyerUtmSourceKey = 'appsflyer_utm_source';
const appsFlyerUtmCampaignKey = 'appsflyer_utm_campaign';
const appsFlyerUtmMediumKey = 'appsflyer_utm_medium';
const appsFlyerReferrerIdKey = 'appsflyer_referrer_id';

abstract class AttributionManager {
  /// Intialize all sdk and  set required event handlers
  Future<void> intializeSdk();

  Future<bool> logEvent(String eventName, Map<dynamic, dynamic> eventDetails);

  Future<Map<String, String>> getAttributionData();
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
      debugPrint("res: $res");
      final result = res as Map?;
      final payload = result?['payload'] as Map?;

      if (payload == null) {
        return;
      }

      final utmSource = payload['utm_source'] as String?;
      final utmCampaign = payload['utm_campaign'] as String?;
      final utmMedium = payload['utm_medium'] as String?;
      final referrerId = payload['referrer_id'] as String?;

      if (utmSource != null) {
        saveAttributionData(appsFlyerUtmSourceKey, utmSource);
      }
      if (utmCampaign != null) {
        saveAttributionData(appsFlyerUtmCampaignKey, utmCampaign);
      }
      if (utmMedium != null) {
        saveAttributionData(appsFlyerUtmMediumKey, utmMedium);
      }
      if (referrerId != null) {
        saveAttributionData(appsFlyerReferrerIdKey, referrerId);
      }
    });

    _appsflyerSdk?.onAppOpenAttribution((res) {
      debugPrint("res: $res");
      final result = res as Map?;
      final payload = result?['payload'] as Map?;

      if (payload == null) {
        return;
      }

      final utmSource = payload['utm_source'] as String?;
      final utmCampaign = payload['utm_campaign'] as String?;
      final utmMedium = payload['utm_medium'] as String?;
      final referrerId = payload['referrer_id'] as String?;

      if (utmSource != null) {
        saveAttributionData(appsFlyerUtmSourceKey, utmSource);
      }
      if (utmCampaign != null) {
        saveAttributionData(appsFlyerUtmCampaignKey, utmCampaign);
      }
      if (utmMedium != null) {
        saveAttributionData(appsFlyerUtmMediumKey, utmMedium);
      }
      if (referrerId != null) {
        saveAttributionData(appsFlyerReferrerIdKey, referrerId);
      }
    });

    _appsflyerSdk?.onDeepLinking((DeepLinkResult dp) {
      switch (dp.status) {
        case Status.FOUND:
          debugPrint(dp.deepLink?.toString());
          final utmSource = dp.deepLink?.getStringValue('utm_source');
          final utmCampaign = dp.deepLink?.getStringValue('utm_campaign');
          final utmMedium = dp.deepLink?.getStringValue('utm_medium');
          final referrerId = dp.deepLink?.getStringValue('referrer_id');

          if (utmSource != null) {
            saveAttributionData(appsFlyerUtmSourceKey, utmSource);
          }
          if (utmCampaign != null) {
            saveAttributionData(appsFlyerUtmCampaignKey, utmCampaign);
          }
          if (utmMedium != null) {
            saveAttributionData(appsFlyerUtmMediumKey, utmMedium);
          }
          if (referrerId != null) {
            saveAttributionData(appsFlyerReferrerIdKey, referrerId);
          }

          // Fluttertoast.showToast(msg: dp.deepLink.toString());
          debugPrint("deep link value: ${dp.deepLink?.deepLinkValue}");
          break;
        case Status.NOT_FOUND:
          debugPrint("deep link not found");
          break;
        case Status.ERROR:
          debugPrint("deep link error: ${dp.error}");
          break;
        case Status.PARSE_ERROR:
          debugPrint("deep link status parsing error");
          break;
      }
    });
  }

  @override
  Future<Map<String, String>> getAttributionData() async {
    final utmSource = await getAttributionString(appsFlyerUtmSourceKey);
    final utmCampaign = await getAttributionString(appsFlyerUtmCampaignKey);
    final utmMedium = await getAttributionString(appsFlyerUtmMediumKey);
    final referrerId = await getAttributionString(appsFlyerReferrerIdKey);

    final Map<String, String> data = {};

    if (utmSource != null) {
      data['utm_source'] = utmSource;
    }
    if (utmCampaign != null) {
      data['utm_campaign'] = utmCampaign;
    }
    if (utmMedium != null) {
      data['utm_medium'] = utmMedium;
    }
    if (referrerId != null) {
      data['referrer_id'] = referrerId;
    }

    return data;
  }

  Future<String?> getAttributionString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<void> saveAttributionData(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }
}
