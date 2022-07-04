import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide ReadContext;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' hide RootProvider;
import 'package:kiwi/kiwi.dart';
import 'package:share_plus/share_plus.dart';
import 'package:worknetwork/api/integrations/devices_api_service.dart';
import 'package:worknetwork/core/features/socket_io/socket_io_manager.dart';
import 'package:worknetwork/core/push_notfications/push_notifications.dart';
import 'package:worknetwork/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:worknetwork/features/signup/presentation/screens/profile_basic_screen.dart';
import 'package:worknetwork/features/signup/presentation/screens/profile_email_screen.dart';

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
    StatusBarColor.setTheme(ThemeType.light);

    await deepLinkManager.handleDeepLink(context);
    await attributionProvider.intializeSdk();
    try {
      await KiwiContainer().resolve<Analytics>().initSdk();
    } catch (exception) {
      debugPrint(exception.toString());
    }

    final socketIOManager =
        context.read(userPermissionNotifierProvider.notifier);
    await socketIOManager.listenPermissions();
  }

  late AppRouter _appRouter;

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      initApp(context);
      final _navigatorKey =
          KiwiContainer().resolve<GlobalKey<NavigatorState>>();
      _appRouter = AppRouter(_navigatorKey);
      return;
    }, []);

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
        child: MaterialApp.router(
          routerDelegate: _appRouter.delegate(),
          routeInformationParser: _appRouter.defaultRouteParser(),
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
            final canvasColor = HexColor.fromHex('#1F2127');
            final borderColor = HexColor.fromHex('#272728');
            const backgroundColor = Colors.black;
            final splashColor = HexColor.fromHex('782BE8');
            final grey = HexColor.fromHex('#808190');
            //HexColor.fromHex("#10141C");
            final buttonColor = HexColor.fromHex('#9146FF');
            return Theme(
              data: AppTheme.darkTheme.copyWith(
                textTheme: TextTheme(
                  headline5: const TextStyle(
                      fontWeight: FontWeight.bold, fontFamily: "Roobert"),
                  headline6: const TextStyle(
                      fontWeight: FontWeight.bold, fontFamily: "Roobert"),
                  headline4: const TextStyle(
                      fontWeight: FontWeight.bold, fontFamily: "Roobert"),
                  headline3: const TextStyle(
                      fontWeight: FontWeight.bold, fontFamily: "Roobert"),
                  caption: TextStyle(
                      fontSize: 14, color: grey, fontFamily: "Roobert"),
                  // subtitle1: const TextStyle(fontWeight: FontWeight.bold),
                  subtitle2: const TextStyle(
                      fontWeight: FontWeight.bold, fontFamily: "Roobert"),
                  button: const TextStyle(
                      fontWeight: FontWeight.bold, fontFamily: "Roobert"),
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
                  iconTheme: IconThemeData(color: buttonColor),
                  color: backgroundColor,
                  elevation: 0,
                  actionsIconTheme: IconThemeData(color: buttonColor),
                ),
                buttonTheme: ButtonThemeData(
                  buttonColor: buttonColor,
                  colorScheme: const ColorScheme.dark(),
                ),
                elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(primary: buttonColor),
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(primary: buttonColor),
                ),
                indicatorColor: buttonColor,
                tabBarTheme: const TabBarTheme(
                  indicatorSize: TabBarIndicatorSize.label,
                ),
                buttonColor: buttonColor,
                dialogBackgroundColor: canvasColor,
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: buttonColor,
                ),
                accentColor: buttonColor,
              ),
              child: child!,
            );
          },
        ),
      ),
    );
  }
}

class NoSplashFactory extends InteractiveInkFeatureFactory {
  const NoSplashFactory();

  @override
  InteractiveInkFeature create(
      {required MaterialInkController controller,
      required RenderBox referenceBox,
      required Offset position,
      required Color color,
      required TextDirection textDirection,
      bool containedInkWell = false,
      RectCallback? rectCallback,
      BorderRadius? borderRadius,
      ShapeBorder? customBorder,
      double? radius,
      VoidCallback? onRemoved}) {
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
              color: Theme.of(context).accentColor,
            ),
          ),
        ),
      );
    },
  );
}

Future<bool> showEmail(BuildContext context) async {
  var email = BlocProvider.of<AuthBloc>(context).state.user?.email;

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
      return const ProfileEmailScreen(
        editMode: true,
        popup: true,
      );
    },
  );

  await Future.delayed(const Duration(milliseconds: 500));

  email = BlocProvider.of<AuthBloc>(context).state.user?.email;

  if (email != null && email.isNotEmpty) {
    return true;
  }

  return false;
}

Future<bool> showName(BuildContext context) async {
  var name = BlocProvider.of<AuthBloc>(context).state.user?.name;

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
              )));
    },
  );

  await Future.delayed(const Duration(milliseconds: 500));

  name = BlocProvider.of<AuthBloc>(context).state.user?.name;

  if (name != null && name.isNotEmpty) {
    return true;
  }

  return false;
}

void shareApp(BuildContext context, String url, String description) async {
  // A builder is used to retrieve the context immediately
  // surrounding the ElevatedButton.
  //
  // The context's `findRenderObject` returns the first
  // RenderObject in its descendent tree when it's not
  // a RenderObjectWidget. The ElevatedButton's RenderObject
  // has its position and size after it's built.
  final box = context.findRenderObject() as RenderBox?;

  await Share.share(url,
      subject: description,
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
}
