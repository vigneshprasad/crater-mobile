import 'package:equatable/equatable.dart';

class NumberOfMeetings extends Equatable {
  final String label;
  final int value;

  const NumberOfMeetings({
    this.label,
    this.value,
  });

  @override
  List<Object> get props => [
        label,
        value,
      ];
}
