import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:worknetwork/constants/app_hive_boxes.dart';
import 'package:worknetwork/features/auth/domain/entity/user_profile_field_detail_entity.dart';

part 'user_profile_field_detail.g.dart';

// @HiveType(typeId: AppHiveTypeIds.userProfileFieldDetail)
@JsonSerializable()
class UserProfileFieldDetailModel extends UserProfileFieldDetail {
  @HiveField(0)
  final String? name;

  UserProfileFieldDetailModel({this.name}) : super(name: name);

  factory UserProfileFieldDetailModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFieldDetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserProfileFieldDetailModelToJson(this);
}
