import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:package_info/package_info.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'package:worknetwork/core/config_reader/config_reader.dart';

abstract class Logger {
  Future<void> captureException({
    dynamic exception,
    StackTrace? stackTrace,
  });
}

class LoggerImpl implements Logger {
  final SentryClient sentryClient;
  final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  LoggerImpl(this.sentryClient);

  @override
  Future<void> captureException({
    dynamic exception,
    dynamic stackTrace,
  }) async {
    if (exception is SentryException && stackTrace is SentryStackTrace) {
      if (ConfigReader.getEnv() == "prod") {
        final event = await getSentryEvent(exception: exception);
        await sentryClient.captureEvent(event, stackTrace: stackTrace);
      }
    }
  }

  Future<SentryEvent> getSentryEvent({SentryException? exception}) async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();

    if (Platform.isAndroid) {
      final androidDeviceInfo = await deviceInfo.androidInfo;
      return SentryEvent(
        release: packageInfo.version,
        environment: ConfigReader.getEnv(),
        extra: <String, dynamic>{
          'type': androidDeviceInfo.type,
          'model': androidDeviceInfo.model,
          'device': androidDeviceInfo.device,
          'id': androidDeviceInfo.id,
          'androidId': androidDeviceInfo.androidId,
          'brand': androidDeviceInfo.brand,
          'display': androidDeviceInfo.display,
          'hardware': androidDeviceInfo.hardware,
          'manufacturer': androidDeviceInfo.manufacturer,
          'product': androidDeviceInfo.product,
          'version': androidDeviceInfo.version.release,
          'supported32BitAbis': androidDeviceInfo.supported32BitAbis,
          'supported64BitAbis': androidDeviceInfo.supported64BitAbis,
          'supportedAbis': androidDeviceInfo.supportedAbis,
          'isPhysicalDevice': androidDeviceInfo.isPhysicalDevice,
        },
        exceptions: exception != null ? [exception] : null,
      );
    }

    if (Platform.isIOS) {
      final IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      return SentryEvent(
        release: packageInfo.version,
        environment: ConfigReader.getEnv(),
        extra: <String, dynamic>{
          'name': iosDeviceInfo.name,
          'model': iosDeviceInfo.model,
          'systemName': iosDeviceInfo.systemName,
          'systemVersion': iosDeviceInfo.systemVersion,
          'localizedModel': iosDeviceInfo.localizedModel,
          'utsname': iosDeviceInfo.utsname.sysname,
          'identifierForVendor': iosDeviceInfo.identifierForVendor,
          'isPhysicalDevice': iosDeviceInfo.isPhysicalDevice,
        },
        exceptions: exception != null ? [exception] : null,
      );
    }

    return SentryEvent(
      release: packageInfo.version,
      environment: ConfigReader.getEnv(),
      exceptions: exception != null ? [exception] : null,
    );
  }
}
