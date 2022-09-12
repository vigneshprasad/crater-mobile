import 'package:flutter_segment/flutter_segment.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/core/analytics/anlytics_events.dart';
import 'package:worknetwork/core/attribution/attribution_manager.dart';
import 'package:worknetwork/core/config_reader/config_reader.dart';
import 'package:worknetwork/core/error/exceptions.dart';
import 'package:worknetwork/core/network_info/network_info.dart';
import 'package:worknetwork/core/push_notfications/push_notifications.dart';
import 'package:worknetwork/features/auth/presentation/screens/splash/splash_screen_state.dart';

final analyticsProvider = Provider(
  (ref) {
    return AnalyticsImpl(ref.read);
  },
);

abstract class Analytics {
  /// Intialize Sdk and set base properties
  /// throws => [AnalyticsException]
  Future<void> initSdk();

  /// Makes indentify call to Analytics Service
  /// tracks properties of a user to service.
  /// throws => [AnalyticsException]
  Future<void> identify({
    Map<String, dynamic>? properties,
    Map<String, dynamic>? options,
  });

  /// Makes track event call to Analytics Service
  /// logs custom event to anlytics service.
  /// throws => [AnalyticsException]
  Future<void> trackEvent({
    required String eventName,
    Map<String, dynamic>? properties,
    Map<String, dynamic>? options,
  });

  /// Makes track Screen call to Analytics Service
  /// logs screen loaded event to anlytics service.
  /// throws => [AnalyticsException]
  Future<void> trackScreen({
    required String screenName,
    Map<String, dynamic>? properties,
    Map<String, dynamic>? options,
  });

  /// Makes reset call to Analytics Service
  /// Clears any stored data
  /// throws => [AnalyticsException]
  Future<void> reset();
}

class AnalyticsImpl implements Analytics {
  late final NetworkInfo networkInfo;
  Reader read;

  AnalyticsImpl(this.read) {
    networkInfo = read(networkInfoProvider);
  }

  @override
  Future<void> initSdk() async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      final token = await read(pushNotificationsProvider).getPushToken();
      try {
        final isDebug = ConfigReader.getEnv() != "prod";
        final config = SegmentConfig(
          writeKey: ConfigReader.getSegmentWriteKey(),
          debug: isDebug,
          trackApplicationLifecycleEvents: true,
        );
        Segment.config(
          options: config,
        );
        await Segment.setContext({
          "device": {
            "token": token,
          },
        });
        await Segment.track(eventName: AnalyticsEvents.applicationOpened);
      } catch (error) {
        throw AnalyticsException(error);
      }
    }
  }

  @override
  Future<void> identify({
    Map<String, dynamic>? properties,
    Map<String, dynamic>? options,
  }) async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      final user = read(authStateProvider.notifier).getUser();
      try {
        await Segment.identify(
          userId: user?.pk,
          traits: properties,
          options: options,
        );
      } catch (error) {
        throw AnalyticsException(error);
      }
    }
  }

  @override
  Future<void> trackEvent({
    required String eventName,
    Map<String, dynamic>? properties,
    Map<String, dynamic>? options,
  }) async {
    final isConnected = await networkInfo.isConnected;
    final appsflyer = ProviderContainer().read(attributionManagerProvider);

    if (isConnected) {
      try {
        await Segment.track(
          eventName: eventName,
          properties: properties,
          options: options,
        );
        await appsflyer.logEvent(eventName, properties ?? {});
      } catch (error) {
        throw AnalyticsException(error);
      }
    }
  }

  @override
  Future<void> trackScreen({
    required String screenName,
    Map<String, dynamic>? properties,
    Map<String, dynamic>? options,
  }) async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        await Segment.screen(
          screenName: screenName,
          properties: properties,
          options: options,
        );
      } catch (error) {
        throw AnalyticsException(error);
      }
    }
  }

  @override
  Future<void> reset() async {
    try {
      await Segment.reset();
    } catch (error) {
      throw AnalyticsException(error);
    }
  }
}
