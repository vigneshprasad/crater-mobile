import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:worknetwork/core/error/failures/failures.dart';

part 'conversation_failures.freezed.dart';
part 'conversation_failures.g.dart';

enum ConversationFailuresType {
  @JsonValue("genericError")
  genericError,
  @JsonValue("groupMaxSpeakersError")
  groupMaxSpeakersError,
  @JsonValue("groupNotFound")
  groupNotFound,
  @JsonValue("groupAlreadyJoined")
  groupAlreadyJoined,
  @JsonValue("seriesAlreadyRSVPed")
  seriesAlreadyRSVPed,
  @JsonValue('groupStartDateTimeNotInFuture')
  groupStartDateTimeNotInFuture,
  @JsonValue('groupStartLessThan24Hours')
  groupStartLessThan24Hours,
}

@freezed
abstract class ConversationFailure extends Failure with _$ConversationFailure {
  factory ConversationFailure({
    @JsonKey(name: "error_message") String? message,
    @Default(ConversationFailuresType.genericError)
    @JsonKey(name: "error_code")
        ConversationFailuresType errorCode,
  }) = _ConversationFailure;

  factory ConversationFailure.fromJson(Map<String, dynamic> json) =>
      _$ConversationFailureFromJson(json);
}
