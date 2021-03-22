import 'package:freezed_annotation/freezed_annotation.dart';

part 'roundtable_meta_api_response.freezed.dart';
part 'roundtable_meta_api_response.g.dart';

@freezed
abstract class RoundTableMetaApiResponse with _$RoundTableMetaApiResponse {
  factory RoundTableMetaApiResponse({
    int user,
    int upcoming,
    int all,
  }) = _RoundTableMetaApiResponse;

  factory RoundTableMetaApiResponse.fromJson(Map<String, dynamic> json) =>
      _$RoundTableMetaApiResponseFromJson(json);
}
