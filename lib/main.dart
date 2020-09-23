import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart';
import 'package:worknetwork/core/logger/logger.dart';

import 'core/local_storage/local_storage.dart';
import 'core/widgets/root_app.dart';
import 'di/injector.dart';
import 'utils/simple_bloc_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  Di.setup();
  await KiwiContainer().resolve<LocalStorage>().initSdk();
  KiwiContainer().resolve<LocalStorage>().registerAdapters();
  await KiwiContainer().resolve<LocalStorage>().initStorage();
  final Logger logger = KiwiContainer().resolve<Logger>();

  runZonedGuarded(
    () => runApp(RootApp()),
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
