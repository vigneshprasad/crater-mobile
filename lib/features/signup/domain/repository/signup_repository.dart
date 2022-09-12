import 'package:dartz/dartz.dart';

import 'package:worknetwork/core/error/failures/failures.dart';
import 'package:worknetwork/features/signup/data/models/api_models.dart';

abstract class SignupRepository {
  Future<Either<Failure, PostPhoneNumberResponse>> postNewPhoneNumber(
    String phoneNumber,
  );
  Future<Either<Failure, PostPhoneNumberResponse>> postSmsCode(String smsCode);
}
