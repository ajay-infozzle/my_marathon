// ignore_for_file: constant_identifier_names

enum LevelEnum {
  Starter,
  Beginner,
  Elementary,
  Intermediate,
  PreIntermediate,
  UpperIntermediate,
  Advanced,
  Proficiency;

  String toJson() => name;

  static LevelEnum fromJson(String json) => values.byName(json);
}
