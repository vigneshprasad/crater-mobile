// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ArticleModelAdapter extends TypeAdapter<ArticleModel> {
  @override
  final int typeId = 11;

  @override
  ArticleModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ArticleModel(
      pk: fields[0] as int?,
      created: fields[1] as String?,
      picture: fields[2] as String?,
      tag: fields[3] as String?,
      text: fields[4] as String?,
      title: fields[5] as String?,
      websiteTag: fields[6] as String?,
      websiteUrl: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ArticleModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.pk)
      ..writeByte(1)
      ..write(obj.created)
      ..writeByte(2)
      ..write(obj.picture)
      ..writeByte(3)
      ..write(obj.tag)
      ..writeByte(4)
      ..write(obj.text)
      ..writeByte(5)
      ..write(obj.title)
      ..writeByte(6)
      ..write(obj.websiteTag)
      ..writeByte(7)
      ..write(obj.websiteUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ArticleModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleModel _$ArticleModelFromJson(Map<String, dynamic> json) {
  return ArticleModel(
    pk: json['pk'] as int?,
    created: json['created'] as String?,
    picture: json['picture'] as String?,
    tag: json['tag'] as String?,
    text: json['text'] as String?,
    title: json['title'] as String?,
    websiteTag: json['website_tag'] as String?,
    websiteUrl: json['website_url'] as String?,
  );
}

Map<String, dynamic> _$ArticleModelToJson(ArticleModel instance) =>
    <String, dynamic>{
      'pk': instance.pk,
      'created': instance.created,
      'picture': instance.picture,
      'tag': instance.tag,
      'text': instance.text,
      'title': instance.title,
      'website_tag': instance.websiteTag,
      'website_url': instance.websiteUrl,
    };
