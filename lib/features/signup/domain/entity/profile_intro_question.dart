import 'package:hive/hive.dart';

import 'package:worknetwork/features/signup/domain/entity/profile_intro_meta.dart';

class ProfileIntroQuestion extends HiveObject {
  final List<ProfileIntroElement> elements;

  ProfileIntroQuestion(this.elements);
}

class ProfileIntroElement extends HiveObject {
  final String? id;
  final ProfileIntroElementType type;
  final String? value;
  final List<ProfileIntroMeta>? options;
  final double? width;
  final int? lines;
  final String? placeholder;
  final bool? optional;

  ProfileIntroElement({
    this.id,
    required this.type,
    this.value,
    this.options,
    this.width,
    this.lines,
    this.placeholder,
    this.optional,
  });

  static const String name = "name";
  static const String tags = "tags";
  static const String yearsOfExperience = "years_of_experience";
  static const String sector = "sector";
  static const String companyType = "company_type";
  static const String educationLevel = "education_level";
  static const String introduction = "introduction";
}

enum ProfileIntroElementType {
  label,
  text,
  dropdown,
  multiselect,
  newline,
}
