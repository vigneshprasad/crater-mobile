import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:worknetwork/core/config_reader/config_reader.dart';
import 'package:worknetwork/core/environments/environments.dart';
import 'package:worknetwork/core/logger/logger.dart';
import 'package:worknetwork/core/widgets/root_app.dart';
import 'package:worknetwork/firebase_options.dart';

Future<void> mainCommon(String configPath, String env) async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load Configurations
  await ConfigReader.intialize(configPath);

  // Bloc Logger
  if (env != Environment.prod) {
    HttpOverrides.global = MyHttpOverrides();
  }

  await Firebase.initializeApp(
    options: defaultFirebaseOptions,
    name: 'Crater',
  );

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  FlutterError.onError = (details, {bool forceReport = false}) {
    // To check RELEASE mode issue

    if (kDebugMode) {
      debugPrint(details.toString());
      return;
    }

    final sentryClient =
        SentryClient(SentryOptions(dsn: ConfigReader.getSentryDsn()));
    final Logger logger = LoggerImpl(sentryClient);
    logger.captureException(
      exception: details.exception,
      stackTrace: details.stack,
    );
  };

  SentryFlutter.init(
    (options) {
      options.dsn = ConfigReader.getSentryDsn();
      options.debug = kDebugMode;
    },
    appRunner: () => runApp(
      ProviderScope(
        child: RootApp(),
      ),
    ),
  );
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
