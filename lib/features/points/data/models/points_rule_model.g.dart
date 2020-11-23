// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'points_rule_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PointsRuleModelAdapter extends TypeAdapter<PointsRuleModel> {
  @override
  final int typeId = 19;

  @override
  PointsRuleModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PointsRuleModel(
      pointsKey: fields[0] as int,
      desc: fields[1] as String,
      pointsValue: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, PointsRuleModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.pointsKey)
      ..writeByte(1)
      ..write(obj.desc)
      ..writeByte(2)
      ..write(obj.pointsValue);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PointsRuleModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PointsRuleModel _$PointsRuleModelFromJson(Map<String, dynamic> json) {
  return PointsRuleModel(
    pointsKey: json['key'] as int,
    desc: json['desc'] as String,
    pointsValue: json['points_value'] as int,
  );
}

Map<String, dynamic> _$PointsRuleModelToJson(PointsRuleModel instance) =>
    <String, dynamic>{
      'key': instance.pointsKey,
      'desc': instance.desc,
      'points_value': instance.pointsValue,
    };
