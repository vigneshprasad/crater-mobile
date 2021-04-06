import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:worknetwork/core/error/failures/failures.dart';

part 'roundtable_failures.freezed.dart';
part 'roundtable_failures.g.dart';

enum RoundTableFailureType {
  @JsonValue("genericError")
  genericError,
  @JsonValue("groupMaxSpeakersError")
  groupMaxSpeakersError,
}

@freezed
abstract class RoundTableFailure extends Failure with _$RoundTableFailure {
  @Implements(Failure)
  factory RoundTableFailure({
    @JsonKey(name: "error_message") String message,
    @JsonKey(name: "error_code", defaultValue: RoundTableFailureType.genericError)
        RoundTableFailureType errorCode,
  }) = _RoundTableFailure;

  factory RoundTableFailure.fromJson(Map<String, dynamic> json) =>
      _$RoundTableFailureFromJson(json);
}
