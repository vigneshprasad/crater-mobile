import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kiwi/kiwi.dart';

import '../../../../../core/error/failures/failures.dart';
import '../../../../meeting/domain/entity/meeting_config_entity.dart';
import '../../../../meeting/domain/entity/meeting_interest_entity.dart';
import '../../../../meeting/domain/repository/meeting_repository.dart';
import '../../../data/models/create_table_meta/create_table_meta.dart';
import '../../../data/repository/conversation_repository_impl.dart';

part 'create_conversation_state.freezed.dart';

enum ConversationType {
  curated,
  instant,
  ama,
}

final getCreateTableMetaNotifier = StateNotifierProvider.autoDispose
    .family<GetCreatTableMetaNotifier, TableMetaState, ConversationType>(
        (ref, type) {
  final meetingRepository = KiwiContainer().resolve<MeetingRepository>();
  return GetCreatTableMetaNotifier(meetingRepository, type, ref.read);
});

@freezed
abstract class TableMetaState with _$TableMetaState {
  factory TableMetaState.loading() = _TableMetaStateLoading;
  factory TableMetaState.data(CreateTableMeta meta) = _TableMetaStateData;
  factory TableMetaState.error(Failure error, [StackTrace? stackTrace]) =
      _TableMetaStateError;
  factory TableMetaState.emptyConfig() = _TableMetaStateNoConfig;
}

class GetCreatTableMetaNotifier extends StateNotifier<TableMetaState> {
  final MeetingRepository _meetingRepository;
  final ConversationType type;
  final Reader read;

  GetCreatTableMetaNotifier(
    this._meetingRepository,
    this.type,
    this.read,
  ) : super(TableMetaState.loading()) {
    getInitialData(type);
  }

  Future<void> getInitialData(ConversationType type) async {
    state = TableMetaState.loading();

    if (type == ConversationType.curated) {
      await getDataForCuratedConversation();
    } else {
      await getDataForInstantConversation();
    }
  }

  Future<void> getDataForInstantConversation() async {
    final futures = [
      _meetingRepository.getMeetingInterests(),
      read(conversationRepositoryProvider).getInstantConversationTimeSlots(),
    ];

    final response = await Future.wait(futures);

    for (final result in response) {
      if (result.isLeft()) {
        final failure = result.getOrElse(() => null) as Failure;
        state = TableMetaState.error(failure);
        return;
      }
    }

    final interests =
        response[0].getOrElse(() => null) as List<MeetingInterest>;
    final slots = response[1].getOrElse(() => <DateTime>[]) as List<DateTime>;

    state = TableMetaState.data(CreateTableMeta(
      interests: interests,
      timeSlots: slots,
    ));
  }

  Future<void> getDataForCuratedConversation() async {
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
    final config = response[1].getOrElse(() => null) as MeetingConfig?;

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
