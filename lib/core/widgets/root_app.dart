import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' hide RootProvider;
import 'package:kiwi/kiwi.dart';
import 'package:worknetwork/core/integrations/intercom/intercom_provider.dart';
import 'package:worknetwork/core/integrations/user_leap/user_leap_provider.dart';

import '../../constants/theme.dart';
import '../../routes.gr.dart';
import '../../utils/app_localizations.dart';
import '../../utils/root_provider.dart';
import '../analytics/analytics.dart';
import '../attribution/attribution_manager.dart';
import '../color/color.dart';
import '../features/deep_link_manager/deep_link_manager.dart';
import '../status_bar_color/status_bar_color.dart';

class RootApp extends HookWidget {
  Future<void> initApp(BuildContext context) async {
    final deepLinkManager = context.read(deepLinkManagerProvider);
    final attributionProvider = context.read(attributionManagerProvider);
    final userleapProvider = context.read(userLeapProvider);
    final interComProvider = context.read(intercomProvider);
    StatusBarColor.setTheme(ThemeType.light);

    await userleapProvider.initSdk();
    await deepLinkManager.handleDeepLink();
    await attributionProvider.intializeSdk();
    await interComProvider.initSdk();
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
        statusBarIconBrightness: Brightness.light,
        // For iOS.
        // Use [dark] for white status bar and [light] for black status bar.
        statusBarBrightness: Brightness.dark,
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
              final lightBlue = HexColor.fromHex('#283950');
              final darkBlue = HexColor.fromHex('#121823');
              final black = darkBlue;
              //HexColor.fromHex("#10141C");
              final buttonColor = HexColor.fromHex('#C67F70');
              return Theme(
                data: AppTheme.darkTheme.copyWith(
                  backgroundColor: darkBlue,
                  splashFactory: const NoSplashFactory(),
                  highlightColor: Colors.transparent,
                  primaryColor: buttonColor,
                  scaffoldBackgroundColor: darkBlue,
                  canvasColor: darkBlue,
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    backgroundColor: black,
                  ),
                  appBarTheme: AppBarTheme(
                      iconTheme: IconThemeData(color: buttonColor),
                      color: black,
                      elevation: 0,
                      actionsIconTheme: IconThemeData(color: buttonColor)),
                  buttonTheme: ButtonThemeData(
                    buttonColor: darkBlue,
                    colorScheme: const ColorScheme.dark(),
                  ),
                  indicatorColor: Colors.transparent,
                  tabBarTheme: const TabBarTheme(
                    indicatorSize: TabBarIndicatorSize.label,
                  ),
                  buttonColor: buttonColor,
                  dialogBackgroundColor: lightBlue,
                  floatingActionButtonTheme: FloatingActionButtonThemeData(
                      backgroundColor: buttonColor),
                  accentColor: buttonColor,
                ),
                child: child,
              );
            },
          ),
        ),
      ),
    );
  }
}

class NoSplashFactory extends InteractiveInkFeatureFactory {
  const NoSplashFactory();

  @override
  InteractiveInkFeature create({
    MaterialInkController controller,
    RenderBox referenceBox,
    Offset position,
    Color color,
    TextDirection textDirection,
    bool containedInkWell = false,
    Rect Function() rectCallback,
    BorderRadius borderRadius,
    ShapeBorder customBorder,
    double radius,
    VoidCallback onRemoved,
  }) {
    return NoSplash(
      controller: controller,
      referenceBox: referenceBox,
    );
  }
}

class NoSplash extends InteractiveInkFeature {
  NoSplash({
    @required MaterialInkController controller,
    @required RenderBox referenceBox,
  })  : assert(controller != null),
        assert(referenceBox != null),
        super(
          controller: controller,
          referenceBox: referenceBox,
        );

  @override
  void paintFeature(Canvas canvas, Matrix4 transform) {}
}
