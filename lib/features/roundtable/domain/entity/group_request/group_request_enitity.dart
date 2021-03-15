import 'package:freezed_annotation/freezed_annotation.dart';

import '../roundtable_entity/roundtable_entity.dart';

part 'group_request_enitity.freezed.dart';
part 'group_request_enitity.g.dart';

@freezed
abstract class GroupRequest with _$GroupRequest {
  factory GroupRequest({
    int pk,
    int group,
    @JsonKey(name: "group_detail") RoundTable groupDetail,
  }) = _GroupRequest;

  factory GroupRequest.fromJson(Map<String, dynamic> json) =>
      _$GroupRequestFromJson(json);
}
