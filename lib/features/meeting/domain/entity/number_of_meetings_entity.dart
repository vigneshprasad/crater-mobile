import 'package:equatable/equatable.dart';

class NumberOfMeetings extends Equatable {
  final String? label;
  final int? value;

  const NumberOfMeetings({
    this.label,
    this.value,
  });

  @override
  List<Object> get props {
    final List<Object> temp = [];
    if (label != null) temp.add(label!);
    if (value != null) temp.add(value!);
    return temp;
  }
}
