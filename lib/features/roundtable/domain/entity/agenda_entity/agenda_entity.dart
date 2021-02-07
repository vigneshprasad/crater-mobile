import 'package:freezed_annotation/freezed_annotation.dart';

import '../category_entity/category_entity.dart';

part 'agenda_entity.freezed.dart';
part 'agenda_entity.g.dart';

@freezed
abstract class Agenda with _$Agenda {
  factory Agenda({
    String name,
    String creator,
    Category category,
    @JsonKey(name: 'is_approved') bool isApproved,
    @JsonKey(name: 'is_active') bool isActive,
  }) = _Agenda;

  factory Agenda.fromJson(Map<String, dynamic> json) => _$AgendaFromJson(json);
}
