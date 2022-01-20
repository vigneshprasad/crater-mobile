import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_reaction_entity.freezed.dart';
part 'chat_reaction_entity.g.dart';

@freezed
abstract class ChatReaction with _$ChatReaction {
  const factory ChatReaction({
    int? id,
    String? name,
    String? image,
    String? file,
    @Default(true) bool isActive,
    
  }) = _ChatReaction;

  factory ChatReaction.fromJson(Map<String, dynamic> json) =>
      _$ChatReactionFromJson(json);
}
