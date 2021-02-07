import 'package:hooks_riverpod/all.dart';

final roundtableLocalDatasourceProvider =
    Provider<RoundTableLocalDatasource>((_) => RoundTableLocalDatasourceImpl());

abstract class RoundTableLocalDatasource {}

class RoundTableLocalDatasourceImpl implements RoundTableLocalDatasource {}
