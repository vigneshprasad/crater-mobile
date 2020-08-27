// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'points_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PointsModelAdapter extends TypeAdapter<PointsModel> {
  @override
  final int typeId = 26;

  @override
  PointsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PointsModel(
      points: fields[0] as int,
    );
  }

  @override
  void write(BinaryWriter writer, PointsModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.points);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PointsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PointsModel _$PointsModelFromJson(Map<String, dynamic> json) {
  return PointsModel(
    points: json['points'] as int,
  );
}

Map<String, dynamic> _$PointsModelToJson(PointsModel instance) =>
    <String, dynamic>{
      'points': instance.points,
    };
