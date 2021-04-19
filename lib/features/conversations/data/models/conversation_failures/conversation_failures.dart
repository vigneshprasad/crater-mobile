import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/error/failures/failures.dart';

part 'conversation_failures.freezed.dart';
part 'conversation_failures.g.dart';

enum ConversationFailuresType {
  @JsonValue("genericError")
  genericError,
  @JsonValue("groupMaxSpeakersError")
  groupMaxSpeakersError,
  @JsonValue("groupNotFound")
  groupNotFound,
}

@freezed
abstract class ConversationFailure extends Failure with _$ConversationFailure {
  @Implements(Failure)
  factory ConversationFailure({
    @JsonKey(name: "error_message") String message,
    @JsonKey(name: "error_code", defaultValue: ConversationFailuresType.genericError)
        ConversationFailuresType errorCode,
  }) = _ConversationFailure;

  factory ConversationFailure.fromJson(Map<String, dynamic> json) =>
      _$ConversationFailureFromJson(json);
}
