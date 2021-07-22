import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_models.g.dart';

@JsonSerializable()
class PostPhoneNumberResponse extends Equatable {
  final String status;

  const PostPhoneNumberResponse({
    required this.status,
  });

  @override
  List<Object> get props => [status];

  factory PostPhoneNumberResponse.fromJson(Map<String, dynamic> json) =>
      _$PostPhoneNumberResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PostPhoneNumberResponseToJson(this);
}
