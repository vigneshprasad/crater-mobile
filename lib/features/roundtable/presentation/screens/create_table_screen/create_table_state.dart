import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:kiwi/kiwi.dart';

import '../../../../../core/error/failures/failures.dart';
import '../../../../meeting/domain/entity/meeting_config_entity.dart';
import '../../../../meeting/domain/entity/meeting_interest_entity.dart';
import '../../../../meeting/domain/repository/meeting_repository.dart';
import '../../../data/models/create_table_meta/create_table_meta.dart';
import '../../../data/repository/roundtable_repository_impl.dart';
import '../../../domain/entity/topic_entity/topic_entity.dart';
import '../../../domain/repository/roundtable_repository.dart';

part 'create_table_state.freezed.dart';

final getCreateTableMetaNotifier = StateNotifierProvider.autoDispose
    .family<GetCreatTableMetaNotifier, int>((ref, id) {
  final meetingRepository = KiwiContainer().resolve<MeetingRepository>();
  final roundTableRepository = ref.read(roundtableRepositoryProvider);
  return GetCreatTableMetaNotifier(meetingRepository, roundTableRepository, id);
});

@freezed
abstract class TableMetaState with _$TableMetaState {
  factory TableMetaState.loading() = _TableMetaStateLoading;
  factory TableMetaState.data(CreateTableMeta meta) = _TableMetaStateData;
  factory TableMetaState.error(Failure error, [StackTrace stackTrace]) =
      _TableMetaStateError;
  factory TableMetaState.emptyConfig() = _TableMetaStateNoConfig;
}

class GetCreatTableMetaNotifier extends StateNotifier<TableMetaState> {
  final MeetingRepository _meetingRepository;
  final RoundTableRepository _roundTableRepository;
  final int topicId;

  GetCreatTableMetaNotifier(
      this._meetingRepository, this._roundTableRepository, this.topicId)
      : super(TableMetaState.loading()) {
    getCreateTableMetadata(topicId);
  }

  Future<void> getCreateTableMetadata(int topicId) async {
    state = TableMetaState.loading();
    final response = await Future.wait([
      _meetingRepository.getMeetingInterests(),
      _meetingRepository.getMeetingsCoonfigs(),
      _roundTableRepository.getRootTopic(topicId),
    ]);

    for (final result in response) {
      if (result.isLeft()) {
        final failure = result.getOrElse(() => null) as Failure;
        state = TableMetaState.error(failure);
        return;
      }
    }

    final interests =
        response[0].getOrElse(() => null) as List<MeetingInterest>;
    final config = response[1].getOrElse(() => null) as MeetingConfig;
    final topic = response[2].getOrElse(() => null) as Topic;

    if (config == null) {
      state = TableMetaState.emptyConfig();
      return;
    }

    state = TableMetaState.data(CreateTableMeta(
      interests: interests,
      config: config,
      rootTopic: topic,
    ));
  }
}
