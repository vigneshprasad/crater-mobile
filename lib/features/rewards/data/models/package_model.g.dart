// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PackageModelAdapter extends TypeAdapter<PackageModel> {
  @override
  final int typeId = 16;

  @override
  PackageModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PackageModel(
      pk: fields[0] as int?,
      maxPrice: fields[1] as int?,
      maxDiscount: fields[2] as int?,
      maxDiscountPoints: fields[3] as int?,
      title: fields[4] as String?,
      shortDesc: fields[5] as String?,
      listImage: fields[6] as String?,
      coverImage: fields[7] as String?,
      color: fields[8] as String?,
      provider: fields[9] as PackageProviderModel?,
      longDesc: fields[10] as String?,
      pointsConversion: fields[11] as double?,
      isDark: fields[12] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, PackageModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.pk)
      ..writeByte(1)
      ..write(obj.maxPrice)
      ..writeByte(2)
      ..write(obj.maxDiscount)
      ..writeByte(3)
      ..write(obj.maxDiscountPoints)
      ..writeByte(4)
      ..write(obj.title)
      ..writeByte(5)
      ..write(obj.shortDesc)
      ..writeByte(6)
      ..write(obj.listImage)
      ..writeByte(7)
      ..write(obj.coverImage)
      ..writeByte(8)
      ..write(obj.color)
      ..writeByte(9)
      ..write(obj.provider)
      ..writeByte(10)
      ..write(obj.longDesc)
      ..writeByte(11)
      ..write(obj.pointsConversion)
      ..writeByte(12)
      ..write(obj.isDark);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PackageModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PackageModel _$PackageModelFromJson(Map<String, dynamic> json) {
  return PackageModel(
    pk: json['pk'] as int?,
    maxPrice: json['max_price'] as int?,
    maxDiscount: json['max_discount'] as int?,
    maxDiscountPoints: json['max_discount_points'] as int?,
    title: json['title'] as String?,
    shortDesc: json['short_desc'] as String?,
    listImage: json['list_image'] as String?,
    coverImage: json['cover_image'] as String?,
    color: json['color'] as String?,
    provider: json['provider'] == null
        ? null
        : PackageProviderModel.fromJson(
            json['provider'] as Map<String, dynamic>),
    longDesc: json['long_desc'] as String?,
    pointsConversion: (json['points_conversion'] as num?)?.toDouble(),
    isDark: json['is_dark'] as bool?,
  );
}

Map<String, dynamic> _$PackageModelToJson(PackageModel instance) =>
    <String, dynamic>{
      'pk': instance.pk,
      'max_price': instance.maxPrice,
      'max_discount': instance.maxDiscount,
      'max_discount_points': instance.maxDiscountPoints,
      'title': instance.title,
      'short_desc': instance.shortDesc,
      'list_image': instance.listImage,
      'cover_image': instance.coverImage,
      'color': instance.color,
      'provider': instance.provider,
      'long_desc': instance.longDesc,
      'points_conversion': instance.pointsConversion,
      'is_dark': instance.isDark,
    };
