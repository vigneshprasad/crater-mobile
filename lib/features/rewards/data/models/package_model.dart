import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../constants/app_hive_boxes.dart';
import '../../domain/entity/package_entity.dart';
import 'package_provider_model.dart';

part 'package_model.g.dart';

// ignore_for_file: annotate_overrides
// ignore_for_file: overridden_fields

@JsonSerializable()
@HiveType(typeId: AppHiveTypeIds.package)
class PackageModel extends Package {
  @HiveField(0)
  final int? pk;

  @HiveField(1)
  @JsonKey(name: 'max_price')
  final int? maxPrice;

  @HiveField(2)
  @JsonKey(name: 'max_discount')
  final int? maxDiscount;

  @HiveField(3)
  @JsonKey(name: 'max_discount_points')
  final int? maxDiscountPoints;

  @HiveField(4)
  final String? title;

  @HiveField(5)
  @JsonKey(name: 'short_desc')
  final String? shortDesc;

  @HiveField(6)
  @JsonKey(name: 'list_image')
  final String? listImage;

  @HiveField(7)
  @JsonKey(name: 'cover_image')
  final String? coverImage;

  @HiveField(8)
  final String? color;

  @HiveField(9)
  final PackageProviderModel? provider;

  @HiveField(10)
  @JsonKey(name: 'long_desc')
  final String? longDesc;

  @HiveField(11)
  @JsonKey(name: 'points_conversion')
  final double? pointsConversion;

  @HiveField(12)
  @JsonKey(name: 'is_dark')
  final bool? isDark;

  PackageModel({
    this.pk,
    this.maxPrice,
    this.maxDiscount,
    this.maxDiscountPoints,
    this.title,
    this.shortDesc,
    this.listImage,
    this.coverImage,
    this.color,
    this.provider,
    this.longDesc,
    this.pointsConversion,
    this.isDark,
  }) : super(
          pk: pk,
          maxPrice: maxPrice,
          maxDiscount: maxDiscount,
          maxDiscountPoints: maxDiscountPoints,
          title: title,
          shortDesc: shortDesc,
          listImage: listImage,
          coverImage: coverImage,
          color: color,
          provider: provider,
          longDesc: longDesc,
          pointsConversion: pointsConversion,
          isDark: isDark,
        );

  factory PackageModel.fromJson(Map<String, dynamic> json) =>
      _$PackageModelFromJson(json);
  Map<String, dynamic> toJson() => _$PackageModelToJson(this);
}
