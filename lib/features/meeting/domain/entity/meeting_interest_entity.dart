import 'package:equatable/equatable.dart';

class MeetingInterest extends Equatable {
  final int pk;
  final String name;

  const MeetingInterest({
    this.pk,
    this.name,
  });

  @override
  List<Object> get props => [
        pk,
        name,
      ];
}
