import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'article_model.dart';

part 'api_models.g.dart';

@JsonSerializable()
class ArticlesPageApiResponse extends Equatable {
  final int? count;

  @JsonKey(name: "current_page")
  final int? currentPage;

  final String? next;

  final int? pages;

  final String? previous;

  final List<ArticleModel>? results;

  const ArticlesPageApiResponse({
    this.count,
    this.currentPage,
    this.next,
    this.pages,
    this.previous,
    this.results,
  });

  @override
  List<Object> get props {
    final List<Object> temp = [];
    if (count != null) temp.add(count!);
    if (currentPage != null) temp.add(currentPage!);
    if (next != null) temp.add(next!);
    if (pages != null) temp.add(pages!);
    if (previous != null) temp.add(previous!);
    if (results != null) temp.add(results!);
    return temp;
  }

  factory ArticlesPageApiResponse.fromJson(Map<String, dynamic> json) =>
      _$ArticlesPageApiResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ArticlesPageApiResponseToJson(this);
}
