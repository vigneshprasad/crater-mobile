import 'package:freezed_annotation/freezed_annotation.dart';

import '../roundtable_entity/roundtable_entity.dart';

part 'rtc_user_entity.freezed.dart';

@freezed
abstract class RtcUser with _$RtcUser {
  factory RtcUser({
    @Required() RoundTableUser userInfo,
    @Required() String pk,
    @Default(false) bool online,
    @Default(false) bool muted,
    @Default(0) int volume,
  }) = _RtcUser;
}
