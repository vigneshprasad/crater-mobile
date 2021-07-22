import 'package:freezed_annotation/freezed_annotation.dart';

import '../conversation_entity/conversation_entity.dart';

part 'rtc_user_entity.freezed.dart';

@freezed
abstract class RtcUser with _$RtcUser {
  factory RtcUser({
    required ConversationUser userInfo,
    required String pk,
    @Default(false) bool online,
    @Default(false) bool muted,
    @Default(0) int volume,
  }) = _RtcUser;
}
