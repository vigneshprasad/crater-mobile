import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:worknetwork/features/videos/data/models/video_model.dart';

part 'videos_api_response.g.dart';

@JsonSerializable()
class VideosApiResponse extends Equatable {
  final int count;
  final String next;
  final String previous;
  final List<VideoModel> results;

  const VideosApiResponse({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  @override
  List<Object> get props => [
        count,
        next,
        previous,
        results,
      ];

  factory VideosApiResponse.fromJson(Map<String, dynamic> json) =>
      _$VideosApiResponseFromJson(json);
  Map<String, dynamic> toJson() => _$VideosApiResponseToJson(this);
}
