import 'package:freezed_annotation/freezed_annotation.dart';

part 'series_request_entity.freezed.dart';
part 'series_request_entity.g.dart';

@freezed
abstract class SeriesRequest with _$SeriesRequest {
  factory SeriesRequest({
    @JsonKey(name: "series_id") String? seriesId
  }) = _SeriesRequest;

  factory SeriesRequest.fromJson(Map<String, dynamic> json) =>
      _$SeriesRequestFromJson(json);
}
