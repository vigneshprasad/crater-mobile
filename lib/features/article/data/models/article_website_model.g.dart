// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_website_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ArticleWebsiteModelAdapter extends TypeAdapter<ArticleWebsiteModel> {
  @override
  final int typeId = 15;

  @override
  ArticleWebsiteModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ArticleWebsiteModel();
  }

  @override
  void write(BinaryWriter writer, ArticleWebsiteModel obj) {
    writer..writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ArticleWebsiteModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleWebsiteModel _$ArticleWebsiteModelFromJson(Map<String, dynamic> json) {
  return ArticleWebsiteModel(
    pk: json['pk'] as int,
    name: json['name'] as String,
    url: json['url'] as String,
  );
}

Map<String, dynamic> _$ArticleWebsiteModelToJson(
        ArticleWebsiteModel instance) =>
    <String, dynamic>{
      'pk': instance.pk,
      'name': instance.name,
      'url': instance.url,
    };
