import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'notification_model.dart';

part 'api_models.g.dart';

@JsonSerializable()
class GetAllNotificationsPageResponse extends Equatable {
  final int count;

  @JsonKey(name: "current_page")
  final int currentPage;
  final String next;
  final int pages;
  final List<NotificationModel> results;

  const GetAllNotificationsPageResponse({
    this.count,
    this.currentPage,
    this.next,
    this.pages,
    this.results,
  });

  @override
  // TODO: implement props
  List<Object> get props => [
        count,
        currentPage,
        next,
        pages,
        results,
      ];

  factory GetAllNotificationsPageResponse.fromJson(Map<String, dynamic> json) =>
      _$GetAllNotificationsPageResponseFromJson(json);
  Map<String, dynamic> toJson() =>
      _$GetAllNotificationsPageResponseToJson(this);
}
