import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_extra_meta.freezed.dart';
part 'profile_extra_meta.g.dart';

enum FieldType {
  @JsonValue("text-field")
  textField,
  @JsonValue("multi-select")
  multiSelect,
  @JsonValue("drop-down")
  dropDown,
}

@freezed
abstract class Option with _$Option {
  factory Option({
    String name,
    int value,
  }) = _Option;

  factory Option.fromJson(Map<String, dynamic> json) => _$OptionFromJson(json);
}

@freezed
abstract class FormFieldData with _$FormFieldData {
  factory FormFieldData({
    FieldType type,
    List<Option> options,
    String label,
    bool blank,
  }) = _FormFieldData;

  factory FormFieldData.fromJson(Map<String, dynamic> json) =>
      _$FormFieldDataFromJson(json);
}

@freezed
abstract class ProfileExtraMeta with _$ProfileExtraMeta {
  factory ProfileExtraMeta({
    String question,
    Map<String, FormFieldData> meta,
  }) = _ProfileExtraMeta;

  factory ProfileExtraMeta.fromJson(Map<String, dynamic> json) =>
      _$ProfileExtraMetaFromJson(json);
}
