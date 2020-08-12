import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:worknetwork/app.dart';
import 'package:worknetwork/constants/theme.dart';
import 'package:worknetwork/utils/init_hive.dart';
import 'package:worknetwork/utils/root_provider.dart';
import 'package:worknetwork/utils/simple_bloc_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  await initHive();
  final statusbarTheme = SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: AppTheme.primaryLightStatusBar,
      statusBarBrightness: Brightness.dark);
  runApp(
    RootProvider(
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: statusbarTheme,
        child: App(),
      ),
    ),
  );
}
