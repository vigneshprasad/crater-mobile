import 'package:equatable/equatable.dart';

class MeetingInterest extends Equatable {
  final int pk;
  final String name;
  final String? icon;

  const MeetingInterest({
    required this.pk,
    required this.name,
    this.icon,
  });

  @override
  List<Object> get props => [
        pk,
        name,
      ];
}
