import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../../data/models/api_models.dart';
import '../repository/signup_repository.dart';

class UCPostSmsCode
    implements AsyncUseCase<PostPhoneNumberResponse, PostSmsCodeParams> {
  final SignupRepository repository;

  UCPostSmsCode(this.repository);

  @override
  Future<Either<Failure, PostPhoneNumberResponse>> call(
      PostSmsCodeParams params) {
    return repository.postSmsCode(params.smsCode);
  }
}

class PostSmsCodeParams extends Equatable {
  final String smsCode;

  const PostSmsCodeParams({
    this.smsCode,
  });

  @override
  List<Object> get props => [smsCode];
}
