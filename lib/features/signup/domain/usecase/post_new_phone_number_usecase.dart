import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/aysnc_usecase.dart';
import '../../data/models/api_models.dart';
import '../repository/signup_repository.dart';

class UCPostNewPhoneNumber
    implements AsyncUseCase<PostPhoneNumberResponse, PostNewPhoneNumberParams> {
  final SignupRepository repository;

  UCPostNewPhoneNumber(this.repository);

  @override
  Future<Either<Failure, PostPhoneNumberResponse>> call(
      PostNewPhoneNumberParams params) {
    return repository.postNewPhoneNumber(params.phoneNumber);
  }
}

class PostNewPhoneNumberParams extends Equatable {
  final String phoneNumber;

  const PostNewPhoneNumberParams({
    this.phoneNumber,
  });

  @override
  List<Object> get props => [phoneNumber];
}
