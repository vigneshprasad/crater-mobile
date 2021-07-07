import 'dart:convert';

import 'package:flutter/services.dart';

// ignore: avoid_classes_with_only_static_members
abstract class ConfigReader {
  static Map<String, dynamic> _config;

  static Future<void> intialize(String configPath) async {
    final configString = await rootBundle.loadString(configPath);
    _config = jsonDecode(configString) as Map<String, dynamic>;
  }

  static String getEnv() => _config["ENVIRONMENT"] as String;

  static String getApiBaseUrl() => _config["API_BASE_URL"] as String;

  static String getWebSocketBaseUrl() =>
      _config["WEBSOCKET_BASE_URL"] as String;

  static String getOneSignalAppId() => _config["ONE_SIGNAL_APP_ID"] as String;

  static String getLinkedInClientId() =>
      _config["LINKED_IN_CLIENT_ID"] as String;

  static String getLinkedInSecret() => _config["LINKED_IN_SECRET"] as String;

  static String getLinkedInRedirect() =>
      _config["LINKED_IN_REDIRECT"] as String;

  static String getAppleClientId() => _config["APPLE_CLIENT_ID"] as String;

  static String getAppleRedirectUrl() =>
      _config["APPLE_REDIRECT_URL"] as String;

  static String getSentryDsn() => _config["SENTRY_DSN"] as String;

  static String getAccountPageLink() => _config["ACCOUNTS_PAGE_LINK"] as String;

  static String getMeetingFeedbackTypeformLink() =>
      _config["MEETING_FEEDBACK_TYPEFORM"] as String;

  static String getAgoraAppId() => _config["AGORA_APP_ID"] as String;

  static String getAppsFlyerDevkey() => _config["APPSFLYER_DEV_KEY"] as String;

  static String getUserLeapEnvKey() => _config["USERLEAP_ENV_ID"] as String;

  static String getIntercomiOSEnvKey() =>
      _config["INTERCOM_IOS_ENV_ID"] as String;
  static String getIntercomAndroidEnvKey() =>
      _config["INTERCOM_ANDROID_ENV_ID"] as String;
}
