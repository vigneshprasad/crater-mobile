import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:worknetwork/constants/app_hive_boxes.dart';

import '../../domain/entity/package_provider_entity.dart';

part 'package_provider_model.g.dart';

// ignore_for_file: annotate_overrides
// ignore_for_file: overridden_fields

@JsonSerializable()
@HiveType(typeId: AppHiveTypeIds.packageProvider)
class PackageProviderModel extends PackageProvider {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final String logo;

  PackageProviderModel({
    this.name,
    this.description,
    this.logo,
  }) : super(
          name: name,
          description: description,
          logo: logo,
        );

  factory PackageProviderModel.fromJson(Map<String, dynamic> json) =>
      _$PackageProviderModelFromJson(json);
  Map<String, dynamic> toJson() => _$PackageProviderModelToJson(this);
}
