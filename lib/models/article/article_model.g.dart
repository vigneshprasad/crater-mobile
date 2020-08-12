// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ArticleAdapter extends TypeAdapter<Article> {
  @override
  final int typeId = 4;

  @override
  Article read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Article(
      fields[0] as int,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as String,
      fields[5] as String,
      fields[6] as String,
      fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Article obj) {
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
      other is ArticleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Article _$ArticleFromJson(Map<String, dynamic> json) {
  return Article(
    json['pk'] as int,
    json['created'] as String,
    json['picture'] as String,
    json['tag'] as String,
    json['text'] as String,
    json['title'] as String,
    json['website_tag'] as String,
    json['website_url'] as String,
  );
}

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      'pk': instance.pk,
      'created': instance.created,
      'picture': instance.picture,
      'tag': instance.tag,
      'text': instance.text,
      'title': instance.title,
      'website_tag': instance.websiteTag,
      'website_url': instance.websiteUrl,
    };
