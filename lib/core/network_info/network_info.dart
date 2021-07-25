// import 'package:data_connection_checker/data_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  // final dynamic connectionChecker;

  // NetworkInfoImpl({
  // required this.connectionChecker,
  // });

  @override
  Future<bool> get isConnected =>
      Future.value(true); //connectionChecker.hasConnection;
}
