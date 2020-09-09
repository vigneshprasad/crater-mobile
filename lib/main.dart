import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:kiwi/kiwi.dart';

import 'core/local_storage/local_storage.dart';
import 'core/widgets/root_app.dart';
import 'di/injector.dart';
import 'utils/simple_bloc_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  Di.setup();
  await KiwiContainer().resolve<LocalStorage>().initStorage();
  runApp(RootApp());
}
