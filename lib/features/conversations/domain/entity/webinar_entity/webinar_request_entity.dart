import 'package:freezed_annotation/freezed_annotation.dart';

part 'webinar_request_entity.freezed.dart';
part 'webinar_request_entity.g.dart';

@freezed
abstract class WebinarRequest with _$WebinarRequest {
  const factory WebinarRequest({
    String? description,
    required String start,
    required List<int> categories,
    @JsonKey(name: 'topic_title') required String title,
    @JsonKey(name: 'topic_image') required String coverImage,
    @JsonKey(name: 'rtmp_link') String? rtmpLink,
  }) = _WebinarRequest;

  factory WebinarRequest.fromJson(Map<String, dynamic> json) =>
      _$WebinarRequestFromJson(json);
}
