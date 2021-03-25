import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kiwi/kiwi.dart';

import '../../../../../core/api_result/api_result.dart';
import '../../../../../core/error/failures/failures.dart';
import '../../../../meeting/domain/entity/meeting_entity.dart';
import '../../../../meeting/domain/repository/meeting_repository.dart';
import '../../../data/repository/roundtable_repository_impl.dart';
import '../../../domain/entity/optin_entity/optin_entity.dart';
import '../../../domain/entity/roundtable_entity/roundtable_entity.dart';
import '../../../domain/entity/topic_entity/topic_entity.dart';
import '../../../domain/repository/roundtable_repository.dart';
import '../roundtable_tab/roundtable_tab.dart';

part 'roundtables_page_state.freezed.dart';

final roundtablePageStateProvider =
    StateNotifierProvider.family<RoundTablePageNotifier, RoundTablePageType>(
        (ref, type) {
  final roundTableRepository = ref.read(roundtableRepositoryProvider);
  final meetingRepository = KiwiContainer().resolve<MeetingRepository>();

  return RoundTablePageNotifier(type, roundTableRepository, meetingRepository);
});

@freezed
abstract class PageState with _$PageState {
  factory PageState({
    List<RoundTable> tables,
    List<Optin> optins,
    List<Meeting> meetings,
  }) = _PageState;
}

class RoundTablePageNotifier extends StateNotifier<ApiResult<PageState>> {
  final RoundTablePageType type;
  final RoundTableRepository _roundTableRepository;
  final MeetingRepository _meetingRepository;

  RoundTablePageNotifier(
    this.type,
    this._roundTableRepository,
    this._meetingRepository,
  ) : super(ApiResult<PageState>.loading()) {
    getInitalData();
  }

  Future<void> getInitalData() async {
    if (type == RoundTablePageType.all) {
      await _getAllTablesRequest();
    } else {
      await _getMyTablesRequest();
    }
  }

  Future<void> _getAllTablesRequest({List<Topic> filter}) async {
    state = ApiResult<PageState>.loading();
    Either<Failure, List<RoundTable>> response;
    if (filter != null) {
      final filters = filter.map((topic) => topic.id).toList();
      response =
          await _roundTableRepository.getAllRoundTables(topicsIds: filters);
    } else {
      response = await _roundTableRepository.getAllRoundTables();
    }

    state = response.fold(
      (failure) => ApiResult<PageState>.error(failure),
      (tables) => ApiResult<PageState>.data(
        PageState(tables: tables),
      ),
    );
  }

  Future<void> filterTables(List<Topic> topics) async {
    if (type == RoundTablePageType.all) {
      await _getAllTablesRequest(filter: topics);
    } else {
      await _getMyTablesRequest(filter: topics);
    }
  }

  Future<void> _getMyTablesRequest({List<Topic> filter}) async {
    Future<Either<Failure, List<RoundTable>>> getTablesRequest;
    if (filter != null) {
      final filters = filter.map((topic) => topic.id).toList();
      getTablesRequest =
          _roundTableRepository.getAllMyRoundTables(topicsIds: filters);
    } else {
      getTablesRequest = _roundTableRepository.getAllMyRoundTables();
    }
    final futures = [
      getTablesRequest,
      _roundTableRepository.getAllMyOptins(),
      _meetingRepository.getMeetings(),
    ];

    final response = await Future.wait(futures);

    for (final result in response) {
      if (result.isLeft()) {
        final failure = result.getOrElse(() => null) as Failure;
        state = ApiResult<PageState>.error(failure);
        return;
      }
    }

    final tables =
        response[0].getOrElse(() => <RoundTable>[]) as List<RoundTable>;
    final optins = response[1].getOrElse(() => <Optin>[]) as List<Optin>;
    final meetings = response[2].getOrElse(() => <Meeting>[]) as List<Meeting>;

    state = ApiResult.data(
      PageState(
        tables: tables,
        optins: optins,
        meetings: meetings,
      ),
    );
  }
}
