import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kiwi/kiwi.dart';

import '../../constants/theme.dart';
import '../../routes.gr.dart';
import '../../utils/app_localizations.dart';
import '../../utils/root_provider.dart';
import '../features/deep_link_manager/deep_link_manager.dart';
import '../push_notfications/push_notifications.dart';
import '../status_bar_color/status_bar_color.dart';

class RootApp extends StatefulWidget {
  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  GlobalKey<NavigatorState> _navigatorKey;

  @override
  void initState() {
    _navigatorKey = KiwiContainer().resolve<GlobalKey<NavigatorState>>();
    KiwiContainer().resolve<PushNotifications>().initSdk();
    StatusBarColor.setTheme(ThemeType.light);
    KiwiContainer().resolve<DeepLinkManager>().handleDeepLink();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        // For Android.
        // Use [light] for white status bar and [dark] for black status bar.
        statusBarIconBrightness: Brightness.dark,
        // For iOS.
        // Use [dark] for white status bar and [light] for black status bar.
        statusBarBrightness: Brightness.light,
      ),
      child: RootProvider(
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
    );
  }
}
