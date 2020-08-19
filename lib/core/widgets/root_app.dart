import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:worknetwork/di/injector.dart';
import 'package:worknetwork/utils/root_provider.dart';

import '../../constants/theme.dart';
import '../../routes.dart';
import '../../utils/app_localizations.dart';
import '../../utils/one_signal_manager/one_signal_manager.dart';

class RootApp extends StatefulWidget {
  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  final statusbarTheme = SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: AppTheme.primaryLightStatusBar,
      statusBarBrightness: Brightness.dark);

  @override
  void initState() {
    Di.setup();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RootProvider(
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: statusbarTheme,
        child: OneSignalManager(
          child: MaterialApp(
            title: 'WorkNetwork',
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate
            ],
            localeResolutionCallback: (locale, supportedLocales) {
              // Check if the current device locale is supported
              for (final Locale supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale.languageCode &&
                    supportedLocale.countryCode == locale.countryCode) {
                  return supportedLocale;
                }
              }
              // If the locale of the device is not supported, use the first one
              // from the list (English, in this case).
              return supportedLocales.first;
            },
            onGenerateRoute: Routes.onGenerateRoute,
            initialRoute: '/',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
          ),
        ),
      ),
    );
  }
}
