import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'notification_model.dart';

part 'api_models.g.dart';

@JsonSerializable()
class GetAllNotificationsPageResponse extends Equatable {
  final int? count;

  @JsonKey(name: "current_page")
  final int? currentPage;
  final String? next;
  final int? pages;
  final List<NotificationModel>? results;

  const GetAllNotificationsPageResponse({
    this.count,
    this.currentPage,
    this.next,
    this.pages,
    this.results,
  });

  @override
  List<Object> get props {
    final List<Object> temp = [];
    if (count != null) temp.add(count!);
    if (currentPage != null) temp.add(currentPage!);
    if (next != null) temp.add(next!);
    if (pages != null) temp.add(pages!);
    if (results != null) temp.add(results!);
    return temp;
  }

  factory GetAllNotificationsPageResponse.fromJson(Map<String, dynamic> json) =>
      _$GetAllNotificationsPageResponseFromJson(json);
  Map<String, dynamic> toJson() =>
      _$GetAllNotificationsPageResponseToJson(this);
}
