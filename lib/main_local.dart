import 'package:worknetwork/core/environments/environments.dart';
import 'package:worknetwork/main_common.dart';

Future<void> main() async {
  await mainCommon(EnvConfigPath.local, Environment.local);
}
