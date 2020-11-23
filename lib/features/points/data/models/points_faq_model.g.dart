// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'points_faq_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PointsFaqModelAdapter extends TypeAdapter<PointsFaqModel> {
  @override
  final int typeId = 18;

  @override
  PointsFaqModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PointsFaqModel(
      pk: fields[0] as int,
      category: fields[1] as String,
      question: fields[2] as String,
      answer: fields[3] as String,
      order: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, PointsFaqModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.pk)
      ..writeByte(1)
      ..write(obj.category)
      ..writeByte(2)
      ..write(obj.question)
      ..writeByte(3)
      ..write(obj.answer)
      ..writeByte(4)
      ..write(obj.order);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PointsFaqModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PointsFaqModel _$PointsFaqModelFromJson(Map<String, dynamic> json) {
  return PointsFaqModel(
    pk: json['pk'] as int,
    category: json['category'] as String,
    question: json['question'] as String,
    answer: json['answer'] as String,
    order: json['order'] as int,
  );
}

Map<String, dynamic> _$PointsFaqModelToJson(PointsFaqModel instance) =>
    <String, dynamic>{
      'pk': instance.pk,
      'category': instance.category,
      'question': instance.question,
      'answer': instance.answer,
      'order': instance.order,
    };
