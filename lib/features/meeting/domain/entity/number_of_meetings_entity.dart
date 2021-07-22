import 'package:equatable/equatable.dart';

class NumberOfMeetings extends Equatable {
  final String label;
  final int value;

  const NumberOfMeetings({
    required this.label,
    required this.value,
  });

  @override
  List<Object> get props => [
        label,
        value,
      ];
}
