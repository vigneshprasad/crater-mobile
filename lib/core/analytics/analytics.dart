import 'package:flutter/material.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:worknetwork/core/analytics/anlytics_events.dart';

import '../../features/auth/data/datasources/auth_local_datasource.dart';
import '../error/exceptions.dart';
import '../network_info/network_info.dart';
import '../push_notfications/push_notifications.dart';

abstract class Analytics {
  /// Intialize Sdk and set base properties
  /// throws => [AnalyticsException]
  Future<void> initSdk();

  /// Makes indentify call to Analytics Service
  /// tracks properties of a user to service.
  /// throws => [AnalyticsException]
  Future<void> identify({
    Map<String, dynamic> properties,
    Map<String, dynamic> options,
  });

  /// Makes track event call to Analytics Service
  /// logs custom event to anlytics service.
  /// throws => [AnalyticsException]
  Future<void> trackEvent({
    @required String eventName,
    Map<String, dynamic> properties,
    Map<String, dynamic> options,
  });

  /// Makes track Screen call to Analytics Service
  /// logs screen loaded event to anlytics service.
  /// throws => [AnalyticsException]
  Future<void> trackScreen({
    @required String screenName,
    Map<String, dynamic> properties,
    Map<String, dynamic> options,
  });

  /// Makes reset call to Analytics Service
  /// Clears any stored data
  /// throws => [AnalyticsException]
  Future<void> reset();
}

class AnalyticsImpl implements Analytics {
  final PushNotifications pushNotifications;
  final AuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AnalyticsImpl(
    this.pushNotifications,
    this.localDataSource,
    this.networkInfo,
  );

  @override
  Future<void> initSdk() async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      final token = await pushNotifications.getPushToken();
      try {
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
    Map<String, dynamic> properties,
    Map<String, dynamic> options,
  }) async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      final user = localDataSource.getUserFromCache();
      try {
        await Segment.identify(
            userId: user.pk, traits: properties, options: options);
      } catch (error) {
        throw AnalyticsException(error);
      }
    }
  }

  @override
  Future<void> trackEvent({
    String eventName,
    Map<String, dynamic> properties,
    Map<String, dynamic> options,
  }) async {
    final isConnected = await networkInfo.isConnected;

    if (isConnected) {
      try {
        await Segment.track(
            eventName: eventName, properties: properties, options: options);
      } catch (error) {
        throw AnalyticsException(error);
      }
    }
  }

  @override
  Future<void> trackScreen({
    String screenName,
    Map<String, dynamic> properties,
    Map<String, dynamic> options,
  }) async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        await Segment.screen(
            screenName: screenName, properties: properties, options: options);
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
