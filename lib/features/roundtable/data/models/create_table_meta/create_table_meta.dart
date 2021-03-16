import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../meeting/domain/entity/meeting_config_entity.dart';
import '../../../../meeting/domain/entity/meeting_interest_entity.dart';
import '../../../domain/entity/topic_entity/topic_entity.dart';

part 'create_table_meta.freezed.dart';

@freezed
abstract class CreateTableMeta with _$CreateTableMeta {
  factory CreateTableMeta({
    List<MeetingInterest> interests,
    MeetingConfig config,
  }) = _CreateTableMeta;
}
