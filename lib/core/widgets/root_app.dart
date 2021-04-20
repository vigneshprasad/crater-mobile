import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' hide RootProvider;
import 'package:kiwi/kiwi.dart';

import '../../constants/theme.dart';
import '../../routes.gr.dart';
import '../../utils/app_localizations.dart';
import '../../utils/root_provider.dart';
import '../analytics/analytics.dart';
import '../attribution/attribution_manager.dart';
import '../features/deep_link_manager/deep_link_manager.dart';
import '../status_bar_color/status_bar_color.dart';

class RootApp extends HookWidget {
  Future<void> initApp(BuildContext context) async {
    final deepLinkManager = context.read(deepLinkManagerProvider);
    final attributionProvider = context.read(attributionManagerProvider);
    StatusBarColor.setTheme(ThemeType.light);

    await deepLinkManager.handleDeepLink();
    await attributionProvider.intializeSdk();
    await KiwiContainer().resolve<Analytics>().initSdk();
  }

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      initApp(context);
      return;
    }, []);

    final GlobalKey<NavigatorState> _navigatorKey =
        KiwiContainer().resolve<GlobalKey<NavigatorState>>();

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
          builder: ExtendedNavigator.builder<Router>(
            router: Router(),
            initialRoute: "/",
            navigatorKey: _navigatorKey,
            observers: [
              SegmentObserver(),
            ],
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
