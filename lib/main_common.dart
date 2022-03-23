import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kiwi/kiwi.dart';

import 'core/config_reader/config_reader.dart';
import 'core/environments/environments.dart';
import 'core/local_storage/local_storage.dart';
import 'core/logger/logger.dart';
import 'core/push_notfications/push_notifications.dart';
import 'core/widgets/root_app.dart';
import 'di/injector.dart';
import 'firebase_options.dart';
import 'utils/simple_bloc_observer.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> mainCommon(String configPath, String env) async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load Configurations
  await ConfigReader.intialize(configPath);

  // Bloc Logger
  if (env != Environment.prod) {
    Bloc.observer = SimpleBlocObserver();
    HttpOverrides.global = MyHttpOverrides();
  }

  // Setup KiwiContainer (Dependency Injection Contianers)
  Di.setup();
  await KiwiContainer().resolve<LocalStorage>().initSdk();
  KiwiContainer().resolve<LocalStorage>().registerAdapters();
  await KiwiContainer().resolve<LocalStorage>().initStorage();
  final Logger logger = KiwiContainer().resolve<Logger>();
  KiwiContainer().resolve<PushNotifications>().initSdk();

  // WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    name: 'Crater',
  );

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // Run App wrapped with Sentry Logger
  runZonedGuarded(
    () => runApp(
      ProviderScope(
        child: RootApp(),
      ),
    ),
    (error, stackTrace) async {
      // To check RELEASE mode issue
      // Fluttertoast.showToast(msg: 'some exception' + stackTrace.toString());
      await logger.captureException(
        exception: error,
        stackTrace: stackTrace,
      );
    },
  );

  FlutterError.onError = (details, {bool forceReport = false}) {
    // To check RELEASE mode issue
    // Fluttertoast.showToast(msg: 'some error' + details.exceptionAsString());
    logger.captureException(
      exception: details.exception,
      stackTrace: details.stack,
    );
  };
}
