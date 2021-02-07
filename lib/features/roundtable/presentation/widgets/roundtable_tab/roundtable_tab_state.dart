import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/all.dart';

import '../../../../../core/api_result/api_result.dart';
import '../../../../../core/error/failures/failures.dart';
import '../../../data/models/roundtable_meta_api_response/roundtable_meta_api_response.dart';
import '../../../data/repository/roundtable_repository_impl.dart';
import '../../../domain/repository/roundtable_repository.dart';

final roundTableMetaStateNotifierProvider =
    StateNotifierProvider.autoDispose((ref) {
  final repository = ref.read(roundtableRepositoryProvider);
  return RoundTableMetaNotifier(repository);
});

class RoundTableMetaNotifier
    extends StateNotifier<ApiResult<RoundTableMetaApiResponse>> {
  final RoundTableRepository _repository;
  RoundTableMetaNotifier(this._repository)
      : super(ApiResult<RoundTableMetaApiResponse>.loading()) {
    getRoundTableMetaInfo();
  }

  Future<Either<Failure, RoundTableMetaApiResponse>>
      getRoundTableMetaInfo() async {
    final response = await _repository.getRoundTableMetaInfo();

    state = response.fold(
      (failure) => ApiResult<RoundTableMetaApiResponse>.error(failure),
      (meta) => ApiResult<RoundTableMetaApiResponse>.data(meta),
    );

    return response;
  }
}
