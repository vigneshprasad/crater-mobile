import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:worknetwork/core/api_result/api_result.dart';
import 'package:worknetwork/core/error/failures/failures.dart';
import 'package:worknetwork/features/conversations/data/repository/conversation_repository_impl.dart';
import 'package:worknetwork/features/conversations/domain/entity/series_entity/series_entity.dart';
import 'package:worknetwork/features/conversations/domain/entity/series_request_entity/series_request_entity.dart';

final seriesStateProvider = StateNotifierProvider.autoDispose
    .family<SeriesState, ApiResult<SeriesScreenData>, int>(
  (ref, id) => SeriesState(ref.read, id),
);

class SeriesScreenData {
  final Series series;
  final bool isRSVPed;

  SeriesScreenData(this.series, this.isRSVPed);
}

class SeriesState extends StateNotifier<ApiResult<SeriesScreenData>> {
  final Reader read;
  final int _groupId;

  SeriesState(this.read, this._groupId) : super(ApiResult.loading()) {
    retrieveSeries();
  }

  Future<Either<Failure, Series>> retrieveSeries({
    bool justRSVPed = false,
  }) async {
    final response =
        await read(conversationRepositoryProvider).getSeriesDetails(_groupId);

    final requestResponse = await read(conversationRepositoryProvider)
        .getWebinarRSVPRequest(_groupId);

    state = response.fold(
      (failure) => ApiResult.error(failure),
      (series) {
        final isRSVPed = justRSVPed || requestResponse.isRight();
        final data = SeriesScreenData(series, isRSVPed);
        return ApiResult.data(data);
      },
    );

    return response;
  }

  Future<Either<Failure, SeriesRequest>> postRequestToRSVP() async {
    final request = SeriesRequest(
      seriesId: _groupId.toString(),
    );
    final response = await read(conversationRepositoryProvider)
        .postRequestToRSVPSeries(request);

    return response;
  }
}
