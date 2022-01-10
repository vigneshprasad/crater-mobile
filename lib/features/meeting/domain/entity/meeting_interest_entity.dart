import 'package:equatable/equatable.dart';

class MeetingInterest extends Equatable {
  final int? pk;
  final String? name;
  final String? icon;

  const MeetingInterest({
    this.pk,
    this.name,
    this.icon,
  });

  @override
  List<Object> get props {
    final List<Object> temp = [];
    if (pk != null) temp.add(pk!);
    if (name != null) temp.add(name!);
    if (icon != null) temp.add(icon!);
    return temp;
  }
}
