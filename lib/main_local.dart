import 'core/environments/environments.dart';
import 'main_common.dart';

Future<void> main() async {
  await mainCommon(EnvConfigPath.local, Environment.local);
}
