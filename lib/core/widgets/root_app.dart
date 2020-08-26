import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kiwi/kiwi.dart';
import 'package:worknetwork/di/injector.dart';
import 'package:worknetwork/routes.gr.dart';
import 'package:worknetwork/utils/root_provider.dart';

import '../../constants/theme.dart';
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

  GlobalKey<NavigatorState> _navigatorKey;

  @override
  void initState() {
    Di.setup();
    _navigatorKey = KiwiContainer().resolve<GlobalKey<NavigatorState>>();
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
            debugShowCheckedModeBanner: false,
            builder: ExtendedNavigator.builder(
              router: Router(),
              initialRoute: "/",
              navigatorKey: _navigatorKey,
              builder: (context, child) {
                return Theme(
                  data: AppTheme.lightTheme,
                  child: child,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
