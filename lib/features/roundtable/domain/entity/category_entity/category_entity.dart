import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
part 'category_entity.freezed.dart';
part 'category_entity.g.dart';

@freezed
abstract class Category with _$Category {
  factory Category({
    String name,
    String image,
    @JsonKey(name: 'is_active') bool isActive,
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
}
