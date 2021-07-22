import 'package:hive/hive.dart';

class PackageProvider extends HiveObject {
  final String? name;
  final String? description;
  final String? logo;

  PackageProvider({
    this.name,
    this.description,
    this.logo,
  });
}
