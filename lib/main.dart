import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'core/widgets/root_app.dart';
import 'utils/init_hive.dart';
import 'utils/simple_bloc_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  await initHive();
  runApp(RootApp());
}
