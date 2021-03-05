import 'package:freezed_annotation/freezed_annotation.dart';

part 'optin_entity.freezed.dart';
part 'optin_entity.g.dart';

@freezed
abstract class Optin with _$Optin {
  factory Optin({
    String name,
  }) = _Optin;

  factory Optin.fromJson(Map<String, dynamic> json) => _$OptinFromJson(json);
}
