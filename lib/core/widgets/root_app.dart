import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/core/analytics/analytics.dart';
import 'package:worknetwork/core/attribution/attribution_manager.dart';
import 'package:worknetwork/core/color/color.dart';
import 'package:worknetwork/core/features/deep_link_manager/deep_link_manager.dart';
import 'package:worknetwork/core/features/socket_io/socket_io_manager.dart';
import 'package:worknetwork/core/push_notfications/push_notifications.dart';
import 'package:worknetwork/core/status_bar_color/status_bar_color.dart';
import 'package:worknetwork/features/auth/presentation/screens/splash/splash_screen_state.dart';
import 'package:worknetwork/features/signup/presentation/screens/profile_basic_screen.dart';
import 'package:worknetwork/features/signup/presentation/screens/profile_email_screen.dart';
import 'package:worknetwork/routes.gr.dart';
import 'package:worknetwork/utils/app_localizations.dart';

final navigatorKeyProvider = Provider(
  (ref) {
    return GlobalKey<NavigatorState>();
  },
);

final appRouterProvider = Provider(
  (ref) {
    final key = ref.watch(navigatorKeyProvider);
    return AppRouter(key);
  },
);

class RootApp extends HookConsumerWidget {
  Future<void> initApp(BuildContext context, WidgetRef ref) async {
    ref.read(pushNotificationsProvider).initSdk();

    final deepLinkManager = ref.read(deepLinkManagerProvider);
    final attributionProvider = ref.read(attributionManagerProvider);
    setTheme(ThemeType.light);

    await deepLinkManager.handleDeepLink();
    await attributionProvider.intializeSdk();
    try {
      ref.watch(analyticsProvider).initSdk();
    } catch (exception) {
      debugPrint(exception.toString());
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(
      () {
        initApp(context, ref);
        return;
      },
      [],
    );

    final appRouter = ref.watch(appRouterProvider);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        // For Android.
        // Use [light] for white status bar and [dark] for black status bar.
        statusBarIconBrightness: Brightness.light,
        // For iOS.
        // Use [dark] for white status bar and [light] for black status bar.
        statusBarBrightness: Brightness.dark,
      ),
      child: MaterialApp.router(
        routerDelegate: appRouter.delegate(),
        routeInformationParser: appRouter.defaultRouteParser(),
        title: 'Crater',
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          // Check if the current device locale is supported
          for (final Locale supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale?.languageCode &&
                supportedLocale.countryCode == locale?.countryCode) {
              return supportedLocale;
            }
          }
          // If the locale of the device is not supported, use the first one
          // from the list (English, in this case).
          return supportedLocales.first;
        },
        debugShowCheckedModeBanner: false,
        builder:
            // AutoRouter.builder<Router>(
            //   router: Router(),
            //   initialRoute: "/",
            //   navigatorKey: _navigatorKey,
            //   observers: [
            //     SegmentObserver(),
            //   ],
            // builder:
            (context, child) {
          final canvasColor = HexColor.fromHex('#121212');
          final borderColor = HexColor.fromHex('#373737');
          final backgroundColor = HexColor.fromHex('#010101');
          final splashColor = HexColor.fromHex('#121212');
          final grey = HexColor.fromHex('#C4C4C4');
          //HexColor.fromHex("#10141C");
          final buttonColor = HexColor.fromHex('#882EE8');
          return Theme(
            data: AppTheme.darkTheme.copyWith(
              textTheme: TextTheme(
                headline5: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontFamily: "Outfit",
                ),
                headline6: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontFamily: "Outfit",
                ),
                headline4: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontFamily: "Outfit",
                ),
                headline3: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontFamily: "Outfit",
                ),
                headline2: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontFamily: "Outfit",
                ),
                headline1: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontFamily: "Outfit",
                ),
                caption: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: grey,
                  fontFamily: "Outfit",
                ),
                subtitle2: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontFamily: "Outfit",
                ),
                button: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: "Outfit",
                  fontSize: 16,
                ),
                bodyText2: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontFamily: "Outfit",
                  color: grey,
                ),
              ),

              backgroundColor: backgroundColor,
              // splashFactory: const NoSplashFactory(),
              splashColor: splashColor,
              highlightColor: Colors.transparent,
              primaryColor: buttonColor,
              scaffoldBackgroundColor: backgroundColor,
              canvasColor: canvasColor,
              outlinedButtonTheme: OutlinedButtonThemeData(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  side: BorderSide(
                    color: borderColor,
                    width: 2,
                  ),
                  // backgroundColor: darkBlue,
                  primary: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                selectedItemColor: buttonColor,
              ),
              appBarTheme: AppBarTheme(
                color: backgroundColor,
                elevation: 0,
              ),
              buttonTheme: ButtonThemeData(
                buttonColor: buttonColor,
                colorScheme: const ColorScheme.dark(),
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.black,
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    fontFamily: "Outfit",
                    color: grey,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 42, vertical: 14),
                  shape: const RoundedRectangleBorder(),
                ),
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(primary: grey),
              ),
              indicatorColor: buttonColor,
              tabBarTheme: const TabBarTheme(
                indicatorSize: TabBarIndicatorSize.label,
              ),
              buttonColor: buttonColor,
              dividerColor: borderColor,
              dialogBackgroundColor: canvasColor,
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: buttonColor,
              ),
              colorScheme:
                  ColorScheme.fromSwatch().copyWith(secondary: buttonColor),
            ),
            child: child!,
          );
        },
      ),
    );
  }
}

class NoSplashFactory extends InteractiveInkFeatureFactory {
  const NoSplashFactory();

  @override
  InteractiveInkFeature create({
    required MaterialInkController controller,
    required RenderBox referenceBox,
    required Offset position,
    required Color color,
    required TextDirection textDirection,
    bool containedInkWell = false,
    RectCallback? rectCallback,
    BorderRadius? borderRadius,
    ShapeBorder? customBorder,
    double? radius,
    VoidCallback? onRemoved,
  }) {
    return NoSplash(
      controller: controller,
      referenceBox: referenceBox,
    );
  }
}

class NoSplash extends InteractiveInkFeature {
  NoSplash({
    MaterialInkController? controller,
    RenderBox? referenceBox,
  })  : assert(controller != null),
        assert(referenceBox != null),
        super(
          controller: controller!,
          referenceBox: referenceBox!,
          color: Colors.transparent,
        );

  @override
  void paintFeature(Canvas canvas, Matrix4 transform) {}
}

final overlayProvider = Provider(
  (ref) => OverlayManager(),
);

class OverlayManager {
  OverlayEntry? overlay;

  void show(BuildContext context) {
    hide();
    final overlay = _buildLoaderOverlay();
    Overlay.of(context)?.insert(overlay);
    this.overlay = overlay;
  }

  void hide() {
    if (overlay?.mounted == true) {
      overlay?.remove();
      overlay = null;
    }
  }

  OverlayEntry _buildLoaderOverlay() {
    return OverlayEntry(
      builder: (context) {
        return Container(
          color: Colors.black.withOpacity(0.6),
          child: Center(
            child: SizedBox(
              width: 36,
              height: 36,
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        );
      },
    );
  }
}

OverlayEntry buildLoaderOverlay() {
  return OverlayEntry(
    builder: (context) {
      return Container(
        color: Colors.black.withOpacity(0.6),
        child: Center(
          child: SizedBox(
            width: 36,
            height: 36,
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
      );
    },
  );
}

Future<bool> showEmail(BuildContext context, WidgetRef ref) async {
  var email = ref.read(authStateProvider.notifier).getUser()?.email;

  if (email != null && email.isNotEmpty) {
    return true;
  }
  await showModalBottomSheet(
    elevation: 10,
    backgroundColor: Colors.transparent,
    context: context,
    isDismissible: false,
    enableDrag: false,
    useRootNavigator: false,
    isScrollControlled: true,
    builder: (context) {
      return ProfileEmailScreen(
        editMode: true,
        popup: true,
      );
    },
  );

  await Future.delayed(const Duration(milliseconds: 500));

  email = ref.read(authStateProvider.notifier).getUser()?.email;

  if (email != null && email.isNotEmpty) {
    return true;
  }

  return false;
}

Future<bool> showName(BuildContext context, WidgetRef ref) async {
  var name = ref.read(authStateProvider.notifier).getUser()?.name;

  if (name != null && name.isNotEmpty) {
    return true;
  }
  await showModalBottomSheet(
    elevation: 10,
    backgroundColor: Colors.transparent,
    context: context,
    isDismissible: false,
    enableDrag: false,
    useRootNavigator: false,
    isScrollControlled: true,
    builder: (context) {
      final height = MediaQuery.of(context).size.height * 0.8;
      return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppBorderRadius.bottomSheetRadius),
          topRight: Radius.circular(AppBorderRadius.bottomSheetRadius),
        ),
        child: Container(
          height: height,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).dialogBackgroundColor,
          ),
          child: ProfileBasicScreen(
            editMode: true,
            popup: true,
            onCompletion: () {
              AutoRouter.of(context).pop();
            },
          ),
        ),
      );
    },
  );

  await Future.delayed(const Duration(milliseconds: 500));

  name = ref.read(authStateProvider.notifier).getUser()?.name;

  if (name != null && name.isNotEmpty) {
    return true;
  }

  return false;
}

Future<void> shareApp(
  BuildContext context,
  String url,
  String description,
) async {
  // A builder is used to retrieve the context immediately
  // surrounding the ElevatedButton.
  //
  // The context's `findRenderObject` returns the first
  // RenderObject in its descendent tree when it's not
  // a RenderObjectWidget. The ElevatedButton's RenderObject
  // has its position and size after it's built.
  final box = context.findRenderObject() as RenderBox?;

  await Share.share(
    url,
    subject: description,
    sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
  );
}
