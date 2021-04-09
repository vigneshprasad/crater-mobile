import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kiwi/kiwi.dart';

import '../../../../../core/error/failures/failures.dart';
import '../../../../meeting/domain/entity/meeting_config_entity.dart';
import '../../../../meeting/domain/entity/meeting_interest_entity.dart';
import '../../../../meeting/domain/repository/meeting_repository.dart';
import '../../../data/models/create_table_meta/create_table_meta.dart';

part 'create_conversation_state.freezed.dart';

final getCreateTableMetaNotifier = StateNotifierProvider.autoDispose
    .family<GetCreatTableMetaNotifier, int>((ref, id) {
  final meetingRepository = KiwiContainer().resolve<MeetingRepository>();
  return GetCreatTableMetaNotifier(meetingRepository, id);
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
  final int topicId;

  GetCreatTableMetaNotifier(this._meetingRepository, this.topicId)
      : super(TableMetaState.loading()) {
    getCreateTableMetadata(topicId);
  }

  Future<void> getCreateTableMetadata(int topicId) async {
    state = TableMetaState.loading();
    final response = await Future.wait([
      _meetingRepository.getMeetingInterests(),
      _meetingRepository.getMeetingsCoonfigs(),
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

    if (config == null) {
      state = TableMetaState.emptyConfig();
      return;
    }

    state = TableMetaState.data(CreateTableMeta(
      interests: interests,
      config: config,
    ));
  }
}
