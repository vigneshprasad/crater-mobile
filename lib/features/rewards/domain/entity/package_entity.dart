import 'package:hive/hive.dart';

import 'package_provider_entity.dart';

class Package extends HiveObject {
  final int? pk;
  final int? maxPrice;
  final int? maxDiscount;
  final int? maxDiscountPoints;
  final String? title;
  final String? shortDesc;
  final String? listImage;
  final String? coverImage;
  final String? color;
  final PackageProvider? provider;
  final String? longDesc;
  final double? pointsConversion;
  final bool? isDark;

  Package({
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
  });
}
