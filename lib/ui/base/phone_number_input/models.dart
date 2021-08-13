import 'package:equatable/equatable.dart';

class Country extends Equatable {
  final String isoCode;
  final int countryCode;
  final String? flagCode;

  const Country({
    required this.isoCode,
    required this.countryCode,
    this.flagCode,
  });

  @override
  List<Object> get props => [isoCode, countryCode];
}
