import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:worknetwork/features/meeting/domain/entity/meetings_by_date_entity.dart';

import '../../../domain/entity/conversation_entity/conversation_entity.dart';
import '../../../domain/entity/optin_entity/optin_entity.dart';

part 'calendar_week_data.freezed.dart';

@freezed
abstract class CalendarWeekData with _$CalendarWeekData {
  factory CalendarWeekData({
    bool future,
    DateTime start,
    DateTime end,
    @Default([]) List<ConversationByDate> conversations,
    @Default([]) List<OptinsByDate> optins,
    @Default([]) List<MeetingsByDate> meetings,
  }) = _CalendarWeekData;
}
