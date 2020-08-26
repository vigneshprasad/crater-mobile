import 'package:dartz/dartz.dart';

import '../error/failures.dart';

abstract class SyncUseCase<Type, Params> {
  Either<Failure, Type> call(Params params);
}
