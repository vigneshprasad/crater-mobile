import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'article_model.dart';

part 'api_models.g.dart';

@JsonSerializable()
class ArticlesPageApiResponse extends Equatable {
  final int count;

  @JsonKey(name: "current_page")
  final int currentPage;

  final String next;

  final int pages;

  final String previous;

  final List<ArticleModel> results;

  const ArticlesPageApiResponse({
    required this.count,
    required this.currentPage,
    required this.next,
    required this.pages,
    required this.previous,
    required this.results,
  });

  @override
  List<Object> get props => [
        count,
        currentPage,
        next,
        pages,
        previous,
        results,
      ];

  factory ArticlesPageApiResponse.fromJson(Map<String, dynamic> json) =>
      _$ArticlesPageApiResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ArticlesPageApiResponseToJson(this);
}
