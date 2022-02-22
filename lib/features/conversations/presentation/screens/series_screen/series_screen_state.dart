import 'package:dartz/dartz.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/features/conversations/domain/entity/conversation_entity/conversation_entity.dart';
import 'package:worknetwork/features/conversations/domain/entity/series_entity/series_entity.dart';
import 'package:worknetwork/features/conversations/domain/entity/series_request_entity/series_request_entity.dart';

import '../../../../../core/api_result/api_result.dart';
import '../../../../../core/error/failures/failures.dart';
import '../../../data/repository/conversation_repository_impl.dart';
import '../../../domain/entity/conversation_request_entity/conversation_request_entity.dart';

final seriesStateProvider = StateNotifierProvider.autoDispose
    .family<SeriesState, ApiResult<Series>, int>(
        (ref, id) => SeriesState(ref.read, id));

class SeriesState extends StateNotifier<ApiResult<Series>> {
  final Reader read;
  final int _groupId;

  SeriesState(this.read, this._groupId)
      : super(ApiResult<Series>.loading()) {
    retrieveSeries();
  }

  Future<Either<Failure, Series>> retrieveSeries() async {
    final response = await read(conversationRepositoryProvider)
        .getSeriesDetails(_groupId);

    state = response.fold(
      (failure) => ApiResult<Series>.error(failure),
      (group) {
        return ApiResult<Series>.data(group);
      },
    );

    return response;
  }

  Future<Either<Failure, SeriesRequest>> postRequestToRSVP() async {
    final request = SeriesRequest(
      seriesId: _groupId.toString()
    );
    final response = await read(conversationRepositoryProvider)
        .postRequestToRSVPSeries(request);

    return response;
  }

}