import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kiwi/kiwi.dart';

import 'core/config_reader/config_reader.dart';
import 'core/environments/environments.dart';
import 'core/local_storage/local_storage.dart';
import 'core/logger/logger.dart';
import 'core/push_notfications/push_notifications.dart';
import 'core/widgets/root_app.dart';
import 'di/injector.dart';
import 'utils/simple_bloc_observer.dart';

Future<void> mainCommon(String configPath, String env) async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load Configurations
  await ConfigReader.intialize(configPath);

  // Bloc Logger
  if (env != Environment.prod) {
    Bloc.observer = SimpleBlocObserver();
  }

  // Setup KiwiContainer (Dependency Injection Contianers)
  Di.setup();
  await KiwiContainer().resolve<PushNotifications>().initSdk();
  await KiwiContainer().resolve<LocalStorage>().initSdk();
  KiwiContainer().resolve<LocalStorage>().registerAdapters();
  await KiwiContainer().resolve<LocalStorage>().initStorage();
  final Logger logger = KiwiContainer().resolve<Logger>();

  // Run App wrapped with Sentry Logger
  runZonedGuarded(
    () => runApp(ProviderScope(child: RootApp())),
    (error, stackTrace) async {
      await logger.captureException(
        exception: error,
        stackTrace: stackTrace,
      );
    },
  );

  FlutterError.onError = (details, {bool forceReport = false}) {
    logger.captureException(
      exception: details.exception,
      stackTrace: details.stack,
    );
  };
}
